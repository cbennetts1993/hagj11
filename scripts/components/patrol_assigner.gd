extends Node

signal patrol_path_triggered(path)

@export var patrol_path: Path3D


func trigger():
	if not patrol_path: return
	patrol_path_triggered.emit(patrol_path)
