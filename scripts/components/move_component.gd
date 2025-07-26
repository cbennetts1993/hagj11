class_name MovementComponent extends Node

signal speed_multiplier_changed

@export var body: CharacterBody3D

@export var movement_speed: float = 1.0:
	get = get_current_movement_speed

func get_current_movement_speed() -> float:
	return movement_speed * speed_multiplier


var speed_multiplier: float = 1.0

func set_speed_multiplier(value):
	speed_multiplier = value
	speed_multiplier_changed.emit()


func move(direction: Vector3) -> void:
	body.velocity = direction.rotated(Vector3.UP, body.rotation.y) * get_current_movement_speed()
	body.move_and_slide()
