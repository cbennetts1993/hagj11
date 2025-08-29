extends State

@export var blackboard: Blackboard

@export var vision: VisionComponent
@export var movement: MovementComponent
@export var navigation: NavigationAgent3D

@export var idle_state: State
@export var follow_state: State

@export var animation_player: AnimationPlayer
@export var animation_name: String = "Idle"


func enter(_from: State) -> void:
	navigation.target_position = blackboard.investigate_location
	
	animation_player.play(animation_name)


func update(_delta: float) -> void:
	
	if vision.is_node_visible(blackboard.player):
		state_machine.change_state(follow_state)
		return
	
	if blackboard.has_been_investigated:
		state_machine.change_state(idle_state)
		return
	
	if movement.body.global_position.distance_to(blackboard.investigate_location) <= 0.1:
		state_machine.change_state(idle_state)
		blackboard.has_been_investigated = true
		return


func physics_update(_delta: float) -> void:
	var navigation_path_target: Vector3 = navigation.get_next_path_position()
	var direction: Vector3 = movement.body.global_position.direction_to(navigation_path_target)
	movement.move(direction)
	movement.rotate_to_direction(direction * Vector3(1, 0, 1))
	movement.apply_gravity()
