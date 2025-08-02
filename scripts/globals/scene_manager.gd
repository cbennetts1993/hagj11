extends Node

const main_menu: PackedScene = preload("uid://1bohvsgxrwoc")
const main_level: PackedScene = preload("uid://bkfm8safex0py")
const death_screen: PackedScene = preload("uid://6rdx31co8v26")

@export var loading_screen: Control

func change_to_scene(to: PackedScene) -> void:
	if not to: return
	
	await fade_out().finished
	
	get_tree().paused = true
	get_tree().change_scene_to_packed(to)
	
	await get_tree().create_timer(0.5).timeout
	
	get_tree().paused = false
	fade_in()


func fade_out() -> Tween:
	var tween = create_tween()
	tween.tween_property(loading_screen, "modulate", Color(Color.BLACK, 1.0), 0.5)
	return tween


func fade_in() -> Tween:
	var tween = create_tween()
	tween.tween_property(loading_screen, "modulate", Color(Color.BLACK, 0.0), 0.5)
	return tween
