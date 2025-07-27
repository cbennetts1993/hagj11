extends State

@export var vision: VisionComponent
@export var movement: MovementComponent

@export var idle_state: State
@export var attack_state: State

@export var attack_range: float = 1.0

var player: Player: get = get_player

func get_player() -> Player:
	return Global.player

func update(delta: float):
	if not vision.is_node_visible(player):
		state_machine.change_state(idle_state)
		return
	
	if movement.body.global_position.distance_to(player.global_position) <= attack_range:
		state_machine.change_state(attack_state)
		return


func physics_update(delta: float) -> void:
	var direction = movement.body.global_position.direction_to(player.global_position)
	movement.move(direction)
	movement.apply_gravity()
