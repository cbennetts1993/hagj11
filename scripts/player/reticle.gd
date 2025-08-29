extends Control

@onready var label: Label = $TextureRect/Label
@onready var texture: TextureRect = $TextureRect

func _ready() -> void:
	label.text = ""
	texture.modulate = Color(Color.WHITE, 0.5)
	label.hide()


func _on_collider_updated(collider: Node3D) -> void:
	var data: Resource = get_collider_data(collider)
	label.show()
	
	if data is ItemData:
		label.text = data.name
		texture.modulate = Color.WHITE
		return
	
	label.text = ""
	texture.modulate = Color(Color.WHITE, 0.5)
	label.hide()


func get_collider_data(collider: Node3D) -> Resource:
	if collider is ItemComponent:
		return collider.get_item_data()
	return null
