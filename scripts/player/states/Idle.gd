extends State

@export var input: InputComponent

@export var move_state: State

func update(delta: float):
	
	var input_dir: = input.get_movement_input_vector_direction()
	if not input_dir.is_equal_approx(Vector2.ZERO):
		state_machine.change_state(move_state)
		return
