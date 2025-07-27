extends Area3D

signal got_hit

func emit_got_hit() -> void:
	got_hit.emit()
