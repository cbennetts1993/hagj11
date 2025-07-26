extends State

@export var input: InputComponent
@export var movement: MovementComponent

@export var idle_state: State
@export var fall_state: State

func update(delta: float):
	
	var input_dir: = input.get_movement_input_vector_direction()
	if input_dir.is_equal_approx(Vector2.ZERO):
		state_machine.change_state(idle_state)
		return
	
	if not owner.is_on_floor():
		state_machine.change_state(fall_state)
		return

func physics_update(delta: float) -> void:
	var input_dir: = input.get_movement_input_vector_direction()
	var move_dir: = Vector3(input_dir.y, 0, input_dir.x)
	movement.move(move_dir)
	movement.apply_gravity()
