extends Node

signal patrol_path_triggered(path: Path3D)

@export var patrol_path: Path3D


func trigger() -> void:
	if not patrol_path: return
	patrol_path_triggered.emit(patrol_path)
