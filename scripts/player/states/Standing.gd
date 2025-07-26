extends State

@export var animation: StringName
@export var move_speed_modifier: float = 1.0

@export_group("Components")
@export var animation_player: AnimationPlayer
@export var movement: MovementComponent
@export var input: InputComponent

@export_group("States")
@export var crouch_state: State

func enter(from: State) -> void:
	animation_player.play(animation)
	movement.set_speed_multiplier(move_speed_modifier)


func update(delta: float) -> void:
	
	if input.is_crouch_pressed():
		state_machine.change_state(crouch_state)
		return
