extends Area3D

@export var exclude: Array[Area3D]

func _ready():
	self.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	if exclude.has(area): return
	
	if area.has_signal("got_hit"):
		area.emit_signal("got_hit")
