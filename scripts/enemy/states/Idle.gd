extends State

@export var vision: VisionComponent
@export var movement: MovementComponent

@export var wander_timer: Timer
@export var wander_state: State

@export var follow_state: State
@export var patrol_state: State

var player: Player: get = get_player

func get_player() -> Player:
	return Global.player

func enter(from: State):
	wander_timer.start()


func update(delta: float):
	
	if vision.is_node_visible(player):
		state_machine.change_state(follow_state)
		return
	
	if wander_timer.is_stopped():
		if patrol_state:
			state_machine.change_state(patrol_state)
			return
		else:
			state_machine.change_state(wander_state)
		return
	

func physics_update(delta: float) -> void:
	movement.apply_gravity()
