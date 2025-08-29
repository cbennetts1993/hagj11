class_name InteractRay extends RayCast3D

signal pick_up_item(item: ItemData)
signal collider_changed(collider: Node3D)

var interactable: ItemComponent:
	set(_new):
		if interactable == _new:
			return
			
		interactable = _new
		collider_changed.emit(interactable)


func _physics_process(_delta: float) -> void:
	interactable = get_collider()


func _on_interact() -> void:
	if not is_colliding(): return
	var object: Object = get_collider()
	if object is ItemComponent:
		pick_up_item.emit(object.get_item_data())
		interactable = null
		object.interact()
