class_name Blackboard extends Node

##
## Player
##

var player: Player

func set_player(new_player: Player):
	player = new_player


##
## Investigation
## 

var investigate_location: Vector3: set = set_investigation_position
var has_been_investigated: bool = true

func set_investigation_position(at_position: Vector3):
	investigate_location = at_position
	has_been_investigated = false


##
## General
## 

var data: Dictionary


func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	Global.register_local_player.connect(set_player)


func read(key: StringName) -> Variant:
	return data.get(key)

func write(key: StringName, value: Variant) -> void:
	data.set(key, value)

func has(key: StringName) -> bool:
	return data.get(key) != null
