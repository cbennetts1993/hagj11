class_name InventoryComponent extends Control

signal updated
signal focus_changed(new_focus: ItemData)
signal item_dropped(item: ItemData)

@export var item_name_label: Label
@export var item_description_label: Label
@export var item_icon: TextureRect

var inventory: Array[ItemData]

func add_item(item: ItemData) -> void:
	inventory.append(item)
	updated.emit()
	focus_changed.emit(get_focus_item())

func remove_item(item: ItemData) -> void:
	inventory.erase(item)
	updated.emit()
	focus_changed.emit(get_focus_item())

## Returns the object at 
func get_item_from_index(idx: int) -> ItemData:
	if inventory.is_empty(): return null
	var idx_mod = idx % inventory.size()
	return inventory.get(idx_mod)


func has_item(item: ItemData) -> bool:
	return inventory.has(item)


func _ready():
	self.updated.connect(set_focus_details)
	self.updated.connect(calculate_score)
	set_focus_details()

##
## Carousel function
## 

var focus: int = 0

func get_focus_item() -> ItemData:
	return get_item_from_index(focus)

func increase_focus() -> void:
	focus += 1
	set_focus_details()
	focus_changed.emit(get_focus_item())
	updated.emit()

func decrease_focus() -> void:
	focus -= 1
	set_focus_details()
	focus_changed.emit(get_focus_item())
	updated.emit()


func _on_throw_pressed():
	var item = get_focus_item()
	if not item: return
	
	remove_item(item)
	item_dropped.emit(item)


func set_focus_details(item: ItemData = get_focus_item()) -> void:
	if not item: 
		item_name_label.text = ""
		item_description_label.text = ""
		item_icon.texture = null
		return
	
	item_name_label.text = get_focus_item().name
	item_description_label.text = get_focus_item().description
	item_icon.texture = item.sprite


func calculate_score() -> int:
	var score = Global.compare_relic_array(inventory)
	Global.update_player_score(score)
	return score
