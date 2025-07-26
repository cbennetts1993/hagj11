extends State

@export var movement: MovementComponent
@export var input: InputComponent

@export var move_state: State
@export var fall_state: State

func update(delta: float):
	
	var input_dir: = input.get_movement_input_vector_direction()
	if not input_dir.is_equal_approx(Vector2.ZERO):
		state_machine.change_state(move_state)
		return
		
	if not owner.is_on_floor():
		state_machine.change_state(fall_state)
		return

func physics_update(delta: float) -> void:
	movement.apply_gravity()
