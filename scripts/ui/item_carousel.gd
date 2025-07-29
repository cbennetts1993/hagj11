extends Control

signal focus_changed
signal item_thrown

@export var inventory: InventoryComponent

var focus: int = 0

func get_focus_item() -> ItemData:
	return inventory.get_item_from_index(focus)

func increase_focus() -> void:
	focus += 1

func decrease_focus() -> void:
	focus -= 1


func _on_throw_pressed():
	var item = get_focus_item()
	inventory.remove_item(item)
	item_thrown.emit(item)
