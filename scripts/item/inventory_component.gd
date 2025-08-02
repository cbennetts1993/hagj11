class_name InventoryComponent extends Control

signal updated
signal focus_changed(new_focus: ItemData)
signal item_dropped(item: ItemData)

@export var item_name_label: Label
@export var item_description_label: Label

@export var left_icon: TextureRect
@export var centre_icon: TextureRect
@export var right_icon: TextureRect

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

func get_focus_array(range: int = 1) -> Array[ItemData]:
	var array: Array[ItemData] = []
	for x in range(-range, range):
		var item = get_item_from_index( focus + x )
		array.append(item)
	return array

##
## Carousel function
## 

var focus: int = 0

func get_focus_item() -> ItemData:
	return get_item_from_index(focus)

func increase_focus() -> void:
	focus += 1
	focus_changed.emit()
	set_focus_details()
	updated.emit()

func decrease_focus() -> void:
	focus -= 1
	focus_changed.emit()
	set_focus_details()
	updated.emit()


func _ready():
	updated.connect(set_left_icon)
	updated.connect(set_centre_icon)
	updated.connect(set_right_icon)


func _on_throw_pressed():
	var item = get_focus_item()
	if not item: return
	
	remove_item(item)
	item_dropped.emit(item)


func set_focus_details(item: ItemData = get_focus_item()) -> void:
	if not item: return
	item_name_label.text = get_focus_item().name
	item_description_label.text = get_focus_item().description


func set_left_icon():
	if inventory.is_empty(): return
	var item = get_item_from_index(focus - 1)
	left_icon.texture = item.sprite

func set_centre_icon():
	if inventory.is_empty(): return
	var item = get_item_from_index(focus)
	centre_icon.texture = item.sprite

func set_right_icon():
	if inventory.is_empty(): return
	var item = get_item_from_index(focus + 1)
	centre_icon.texture = item.sprite
