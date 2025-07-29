class_name ItemComponent extends CharacterBody3D

signal interacted

@export var item_data: ItemData

func get_item_data() -> ItemData:
	return item_data

func interact() -> void:
	interacted.emit()
