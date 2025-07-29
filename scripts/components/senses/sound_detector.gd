class_name SoundDetector extends Area3D

signal sound_detected(at_position: Vector3)

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	sound_detected.emit(area.global_position)
	print("detected at position: ", area.global_position)
