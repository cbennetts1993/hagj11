extends State

@export var blackboard: Blackboard

@export var vision: VisionComponent
@export var movement: MovementComponent
@export var navigation: NavigationAgent3D

@export var wander_radius: float
@export var leash_position: Node3D

@export var idle_state: State
@export var follow_state: State
@export var investigate_state: State

var target_position: Vector3


func enter(from: State):
	var rand_direction = Vector3(randf(), 0, randf()).normalized()
	var rand_length = randf_range(0.0, wander_radius)
	target_position = leash_position.global_position + (rand_length * rand_direction)
	navigation.target_position = target_position


func update(delta: float):
	if movement.body.global_position.distance_to(target_position) <= 0.1:
		state_machine.change_state(idle_state)
		return
	
	if not blackboard.has_been_investigated:
		state_machine.change_state(investigate_state)
		return


func physics_update(delta: float) -> void:
	if vision.is_node_visible(blackboard.player):
		state_machine.change_state(follow_state)
		return
	
	var navigation_path_target = navigation.get_next_path_position()
	var direction = movement.body.global_position.direction_to(navigation_path_target)
	movement.move(direction)
	movement.apply_gravity()
