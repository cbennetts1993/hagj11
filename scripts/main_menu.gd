extends Node

func _on_start_pressed() -> void:
	SceneManager.change_to_scene(SceneManager.main_level)


func _on_quit_pressed() -> void:
	get_tree().quit()
