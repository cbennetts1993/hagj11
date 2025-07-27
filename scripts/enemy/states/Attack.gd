extends State

@export var animation: StringName
@export var attack_speed: float = 1.0
@export var animation_player: AnimationPlayer

var return_state: State

var player: Player: get = get_player

func get_player() -> Player:
	return Global.player

func enter(from: State):
	return_state = from
	animation_player.play(animation, -1, attack_speed)


func update(delta: float):
	if not animation_player.is_playing():
		state_machine.change_state(return_state)
		return
