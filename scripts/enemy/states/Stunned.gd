extends State

@export var animation: StringName
@export var animation_player: AnimationPlayer

var return_state: State


func enter(from: State):
	return_state = from
	animation_player.play(animation)


func update(delta: float):
	if not animation_player.is_playing():
		state_machine.change_state(return_state)
		return
	
	print("stunned!")


func stun():
	state_machine.change_state(self)
