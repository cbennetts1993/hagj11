class_name MovementComponent extends Node

signal speed_multiplier_changed

@export var body: CharacterBody3D

@export var movement_speed: float = 1.0:
	get = get_current_movement_speed

func get_current_movement_speed() -> float:
	return movement_speed * speed_multiplier

@export var gravity: float = 9.8


@export_range(0.0, 1.0) var rotation_speed = 1.0

var speed_multiplier: float = 1.0

func set_speed_multiplier(value):
	speed_multiplier = value
	speed_multiplier_changed.emit()


func move(direction: Vector3) -> void:
	body.velocity = direction * get_current_movement_speed()
	body.move_and_slide()

func look_in_direction(direction: Vector3) -> void:
	body.look_at(body.global_position + direction * Vector3(1, 0, 1))

func apply_gravity():
	body.velocity = Vector3.DOWN * gravity
	body.move_and_slide()
