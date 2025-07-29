class_name DamageShape extends Area3D

@export var exclude: Array[Area3D]

func _ready():
	self.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	if exclude.has(area): return
	if area is HitBox:
		area.emit_got_hit()
