extends State

@export var enabled: bool = true

@export var blackboard: Blackboard

@export var vision: VisionComponent
@export var movement: MovementComponent
@export var navigation: NavigationAgent3D

@export var wander_radius: float
@export var leash_position: Node3D

@export var idle_state: State
@export var follow_state: State
@export var investigate_state: State

@export var animation_player: AnimationPlayer
@export var animation_name: String = "Walk"


var target_position: Vector3


func _ready() -> void:
	leash_position.global_position = movement.body.global_position


func enter(_from: State) -> void:
	var rand_direction: = Vector3(randf(), 0, randf()).normalized()
	var rand_length: float = randf_range(1.0, wander_radius)
	target_position = leash_position.global_position + (rand_length * rand_direction)
	navigation.target_position = target_position
	
	animation_player.play(animation_name)


func update(_delta: float) -> void:
	if movement.body.global_position.distance_to(target_position) <= 1.0:
		state_machine.change_state(idle_state)
		return
	
	if not blackboard.has_been_investigated:
		state_machine.change_state(investigate_state)
		return


func physics_update(_delta: float) -> void:
	if vision.is_node_visible(blackboard.player):
		state_machine.change_state(follow_state)
		return
	
	var navigation_path_target: Vector3 = navigation.get_next_path_position()
	var direction: Vector3 = movement.body.global_position.direction_to(navigation_path_target)
	
	movement.move(direction)
	movement.rotate_to_direction(direction * Vector3(1, 0, 1))
	movement.apply_gravity()
