extends Sprite3D

const default: Texture2D = preload("res://assets/sprites/Hand_Test.png")

func set_current_item(item: ItemData) -> void:
	var material = material_override
	if not item:
		material.albedo_texture = default
		return
	
	material.albedo_texture = item.sprite
