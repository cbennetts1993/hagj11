class_name EnemyCommand extends RefCounted

signal completed

func _init() -> void:
	pass

func execute(actor: Enemy, data: Object = null) -> bool:
	return true
