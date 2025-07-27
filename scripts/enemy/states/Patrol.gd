extends State

@export var vision: VisionComponent
@export var movement: MovementComponent

@export var path: Path3D
var current_point_id: int = 0

@export var idle_state: State
@export var follow_state: State

var player: Player: get = get_player

func get_player() -> Player:
	return Global.player

var target_position: Vector3


func enter(from: State):
	target_position = path.curve.get_point_position(current_point_id)


func update(delta: float):
	if movement.body.global_position.distance_to(target_position) <= 0.1:
		current_point_id = ( current_point_id + 1 ) % path.curve.point_count
		return


func physics_update(delta: float) -> void:
	if vision.is_node_visible(player):
		state_machine.change_state(follow_state)
		return
	
	var direction = movement.body.global_position.direction_to(target_position)
	movement.move(direction)
	movement.apply_gravity()
