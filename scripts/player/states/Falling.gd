extends State

@export var animation_player: AnimationPlayer
@export var animation: StringName

@export var movement: MovementComponent
@export var idle_state: State

func enter(from: State):
	animation_player.play(animation)


func update(delta: float):
	if owner.is_on_floor():
		state_machine.change_state(idle_state)
		return


func physics_update(delta: float):
	movement.apply_gravity()
