extends State

@export var blackboard: Blackboard

@export var vision: VisionComponent
@export var movement: MovementComponent
@export var navigation: NavigationAgent3D

@export var investigate_state: State
@export var attack_state: State

@export var attack_range: float = 1.0

@export var animation_name: String = "idle"
@export var animation_front: AnimatedSprite3D
@export var animation_back: AnimatedSprite3D


func enter(from: State) -> void:
	animation_front.animation = animation_name
	animation_back.animation = animation_name

func update(delta: float):
	if not vision.is_node_visible(blackboard.player):
		blackboard.investigate_location = blackboard.player.global_position
		state_machine.change_state(investigate_state)
		return
	
	if movement.body.global_position.distance_to(blackboard.player.global_position) <= attack_range:
		state_machine.change_state(attack_state)
		return
	
	navigation.target_position = blackboard.player.global_position


func physics_update(delta: float) -> void:
	
	var navigation_path_position = navigation.get_next_path_position()
	var direction = movement.body.global_position.direction_to(navigation_path_position)
	movement.move(direction)
	movement.rotate_to_direction(direction * Vector3(1, 0, 1))
	movement.apply_gravity()
