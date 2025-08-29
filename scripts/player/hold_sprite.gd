extends Sprite3D

const default: Texture2D = null

func set_current_item(item: ItemData) -> void:
	if not item:
		texture = default
		return
	
	texture = item.sprite
