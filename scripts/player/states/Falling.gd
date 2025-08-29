extends State

@export var animation_player: AnimationPlayer
@export var animation: StringName

@export var movement: MovementComponent
@export var idle_state: State

func enter(_from: State) -> void:
	animation_player.play(animation)


func update(_delta: float) -> void:
	if owner.is_on_floor():
		state_machine.change_state(idle_state)
		return


func physics_update(_delta: float) -> void:
	movement.apply_gravity()
