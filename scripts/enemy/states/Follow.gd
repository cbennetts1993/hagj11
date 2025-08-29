extends State

@export var blackboard: Blackboard

@export var vision: VisionComponent
@export var movement: MovementComponent
@export var navigation: NavigationAgent3D

@export var investigate_state: State
@export var attack_state: State

@export var attack_range: float = 1.0

@export var animation_player: AnimationPlayer
@export var animation_name: String = "Walk"


func enter(_from: State) -> void:
	animation_player.play(animation_name)


func update(_delta: float) -> void:
	if not vision.is_node_visible(blackboard.player):
		blackboard.investigate_location = blackboard.player.global_position
		state_machine.change_state(investigate_state)
		return
	
	if movement.body.global_position.distance_to(blackboard.player.global_position) <= attack_range:
		state_machine.change_state(attack_state)
		return
	
	navigation.target_position = blackboard.player.global_position


func physics_update(_delta: float) -> void:
	
	var navigation_path_position: Vector3 = navigation.get_next_path_position()
	var direction: Vector3 = movement.body.global_position.direction_to(navigation_path_position)
	movement.move(direction)
	movement.rotate_to_direction(direction * Vector3(1, 0, 1))
	movement.apply_gravity()
