extends Node

const victory_scene: = preload("res://media/victory_screen.tscn")

func trigger():
	SceneManager.change_to_scene(victory_scene)
