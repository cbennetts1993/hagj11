class_name InputComponent extends Node

signal interact_pressed
signal throw_pressed

@export var mouse_mode: Input.MouseMode:
	set = set_mouse_mode

func set_mouse_mode(mode: Input.MouseMode):
	mouse_mode = mode
	Input.mouse_mode = mode


func _process(delta: float) -> void:
	if is_interact_just_pressed():
		interact_pressed.emit()
	
	if is_throw_just_pressed():
		throw_pressed.emit()


## Returns the normalized vector of movement input
func get_movement_input_vector_direction() -> Vector2:
	return Input.get_vector("move_foreward", "move_backward", "strafe_left", "strafe_right").normalized()


func get_camera_pan_direction() -> Vector2:
	return Input.get_vector("camera_pan_right", "camera_pan_left", "camera_pan_up", "camera_pan_down")


func get_mouse_relative_motion_direction() -> Vector2:
	return Input.get_last_mouse_screen_velocity().normalized()


func is_crouch_pressed() -> bool:
	return Input.is_action_pressed("crouch")

func is_interact_just_pressed() -> bool:
	return Input.is_action_just_pressed("interact")

func is_throw_just_pressed() -> bool:
	return Input.is_action_just_pressed("throw")
