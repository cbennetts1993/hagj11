extends Camera3D

@export var input: InputComponent
@export var sensitivity: float = 1.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var pan_direction = event.screen_relative
		
		## Rotation camera along up and down (rotating around the x axis)
		rotation.x -= pan_direction.y * sensitivity
		rotation.x = clampf(rotation.x, -1.0, 1.0)
		
		## Rotation camera along side to side (rotating around the y axis)
		rotate_y(-pan_direction.x * sensitivity)
