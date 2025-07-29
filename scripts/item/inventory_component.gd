class_name InventoryComponent extends Control

signal updated
signal focus_changed
signal item_dropped(item: ItemData)

var inventory: Array[ItemData]

func add_item(item: ItemData) -> void:
	inventory.append(item)
	updated.emit()

func remove_item(item: ItemData) -> void:
	inventory.erase(item)
	updated.emit()

## Returns the object at 
func get_item_from_index(idx: int) -> ItemData:
	if inventory.is_empty(): return null
	var idx_mod = idx % inventory.size()
	return inventory.get(idx_mod)


func has_item(item: ItemData) -> bool:
	return inventory.has(item)

##
## Carousel function
## 

var focus: int = 0

func get_focus_item() -> ItemData:
	return get_item_from_index(focus)

func increase_focus() -> void:
	focus += 1

func decrease_focus() -> void:
	focus -= 1


func _on_throw_pressed():
	var item = get_focus_item()
	if not item: return
	
	remove_item(item)
	item_dropped.emit(item)
