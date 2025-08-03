class_name StateMachine extends Node

@export var base_state: State

var active: bool = true

func activate() -> void:
	active = true

func deactivate() -> void:
	active = false


var state: State


func change_state(target_state: State) -> void:
	if state == target_state: return
	
	if state:
		state.exit(target_state)
	
	if target_state:
		target_state.enter(state)
	
	state = target_state


func _ready():
	for child in get_children():
		if child is State:
			child.state_machine = self
	state = base_state


func _unhandled_input(event: InputEvent) -> void:
	if not active: return
	state.handle_input(event)


func _process(delta: float) -> void:
	if not active: return
	state.update(delta)


func _physics_process(delta: float) -> void:
	if not active: return
	state.physics_update(delta)
