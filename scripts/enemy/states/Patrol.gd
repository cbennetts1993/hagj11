extends State

@export var blackboard: Blackboard

@export var vision: VisionComponent
@export var movement: MovementComponent
@export var navigation: NavigationAgent3D

@export var path: Path3D
var current_point_id: int = 0

@export var idle_state: State
@export var follow_state: State
@export var investigate_state: State

var target_position: Vector3

@export var animation_name: String = "idle"
@export var animation_front: AnimatedSprite3D
@export var animation_back: AnimatedSprite3D


func is_valid() -> bool:
	return path != null


func enter(from: State):
	target_position = path.curve.get_point_position(current_point_id)
	navigation.target_position = target_position
	
	animation_front.animation = animation_name
	animation_back.animation = animation_name


func update(delta: float):
	if not blackboard.has_been_investigated:
		state_machine.change_state(investigate_state)
		return


func physics_update(delta: float) -> void:
	if vision.is_node_visible(blackboard.player):
		state_machine.change_state(follow_state)
		return
	
	if movement.body.global_position.distance_to(target_position) <= 1.2:
		current_point_id = ( current_point_id + 1 ) % path.curve.point_count
		target_position = path.curve.get_point_position(current_point_id)
		navigation.target_position = target_position
		return
	
	var navigation_path_target = navigation.get_next_path_position()
	var direction = movement.body.global_position.direction_to(navigation_path_target)
	
	movement.move(direction)
	movement.rotate_to_direction(direction * Vector3(1, 0, 1))
	movement.apply_gravity()



func assign_patrol_path(new_path: Path3D) -> void:
	path = new_path
