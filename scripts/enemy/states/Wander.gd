extends State

@export var vision: VisionComponent
@export var movement: MovementComponent

@export var wander_radius: float
@export var leash_position: Node3D

@export var idle_state: State
@export var follow_state: State

var player: Player: get = get_player

func get_player() -> Player:
	return Global.player

var target_position: Vector3


func enter(from: State):
	var rand_direction = Vector3(randf(), 0, randf()).normalized()
	var rand_length = randf_range(0.0, wander_radius)
	target_position = leash_position.global_position + (rand_length * rand_direction)


func update(delta: float):
	if movement.body.global_position.distance_to(target_position) <= 0.1:
		state_machine.change_state(idle_state)
		return


func physics_update(delta: float) -> void:
	if vision.is_node_visible(player):
		state_machine.change_state(follow_state)
		return
	
	var direction = movement.body.global_position.direction_to(target_position)
	movement.move(direction)
	movement.apply_gravity()
