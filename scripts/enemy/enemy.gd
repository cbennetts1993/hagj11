extends CharacterBody3D

@export var base_movement_speed: float = 1.0
var movement_multiplier: float = 1.0

func get_movement_speed() -> float:
	return base_movement_speed * movement_multiplier


@export var gravity: float = 9.8
@export_range(0.0, 1.0) var rotation_speed: float = 1.0

func move_in_direction(direction: Vector3) -> void:
	velocity = direction * get_movement_speed()
	velocity.y = -gravity
	
	if direction.length() > 0:
		look_at(self.global_position + (direction * Vector3(1, 0, 1)).normalized() )
	
	move_and_slide()
