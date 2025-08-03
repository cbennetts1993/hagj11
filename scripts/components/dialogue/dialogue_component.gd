class_name DialogueComponent extends Control

@export var dialogue_label: Label
@export var default_duration: float = 1.0

func _ready():
	Global.play_dialogue.connect(start_dialogue)
	hide()


func start_dialogue(text: String, duration: float = default_duration) -> void:
	dialogue_label.text = text
	fade_dialogue()
	show()


func dialogue_finished() -> void:
	dialogue_label.text = ""
	self.modulate = Color(Color.WHITE, 0.0)
	hide()


func fade_dialogue():
	self.modulate = Color(Color.WHITE, 0.0)	
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(Color.WHITE, 1.0), 1.0)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(Color.WHITE, 0.0), 6.0)
