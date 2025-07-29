class_name SoundSource extends Area3D

@export var sound_radius = 5.0

func get_new_sound_collision_shape() -> CollisionShape3D:
	var collision = CollisionShape3D.new()
	var shape = SphereShape3D.new()
	collision.debug_color = Color.GRAY
	collision.shape = shape
	shape.radius = 0.0
	return collision


func create_sound(radius: float = sound_radius) -> void:
	var emission: CollisionShape3D = get_new_sound_collision_shape()
	add_child(emission)
	var tween = create_tween()
	tween.tween_property(emission.shape, "radius", radius, 0.5)
	tween.finished.connect(_on_sound_finished.bind(emission))


func _on_sound_finished(shape: CollisionShape3D) -> void:
	shape.queue_free()
