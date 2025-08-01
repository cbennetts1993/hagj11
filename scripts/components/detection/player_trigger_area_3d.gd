extends Area3D

signal player_triggered

@export var active: bool = true
@export var one_shot: bool = true


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Player) -> void:
	if not active: return
	
	player_triggered.emit()
	
	if one_shot:
		active = false
