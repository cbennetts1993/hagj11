extends State

@export var animation_player: AnimationPlayer
@export var animation_name: String = "Stunned"

var return_state: State


func enter(from: State) -> void:
	return_state = from
	animation_player.play(animation_name)


func update(_delta: float) -> void:
	if not animation_player.is_playing():
		state_machine.change_state(return_state)
		return


func stun() -> void:
	state_machine.change_state(self)
