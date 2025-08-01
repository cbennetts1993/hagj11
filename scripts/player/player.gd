class_name Player extends CharacterBody3D

@export var sensitivity = 0.01

func _ready():
	Global.emit_register_local_player(self)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var pan_direction = event.screen_relative.x
		#rotation.y -= pan_direction * sensitivity


func die():
	SceneManager.change_to_scene(SceneManager.death_screen)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
