extends Camera3D

@export var input: InputComponent
@export var sensitivity: float = 1.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var pan_direction = event.screen_relative.y
		rotation.x -= pan_direction * sensitivity
		rotation.x = clampf(rotation.x, -1.0, 1.0)
