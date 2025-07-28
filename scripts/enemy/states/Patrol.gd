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


func enter(from: State):
	target_position = path.curve.get_point_position(current_point_id)
	navigation.target_position = target_position


func update(delta: float):
	if movement.body.global_position.distance_to(target_position) <= 0.25:
		current_point_id = ( current_point_id + 1 ) % path.curve.point_count
		target_position = path.curve.get_point_position(current_point_id)
		navigation.target_position = target_position
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
