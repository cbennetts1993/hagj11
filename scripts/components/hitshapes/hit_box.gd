class_name HitBox extends Area3D

signal got_hit

func emit_got_hit() -> void:
	print("got hit!")
	got_hit.emit()
