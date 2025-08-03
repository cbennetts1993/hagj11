extends Node

@export_multiline var text: String
@export var duration_override: float = 1.0

func trigger():
	Global.emit_trigger_dialogue(text, duration_override)
