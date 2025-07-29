class_name InteractRay extends RayCast3D

signal pick_up_item(item: ItemData)

func _on_interact():
	if not is_colliding(): return
	var object = get_collider()
	if object is ItemComponent:
		pick_up_item.emit(object.get_item_data())
		object.interact()
