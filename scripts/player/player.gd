class_name Player extends CharacterBody3D

func _ready()-> void:
	Global.emit_register_local_player(self)


func die() -> void:
	SceneManager.change_to_scene(SceneManager.death_screen)
