extends State

@export var attack_speed: float = 1.0
@export var animation_player: AnimationPlayer
@export var animation_name: String = "Attack"

var return_state: State


func enter(from: State) -> void:
	return_state = from
	animation_player.play(animation_name, -1, attack_speed)



func update(_delta: float) -> void:
	if not animation_player.is_playing():
		state_machine.change_state(return_state)
		return
