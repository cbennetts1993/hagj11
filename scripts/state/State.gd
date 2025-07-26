class_name State extends Node
## Basic state for a state machine

signal entered
signal exited

@export var state_machine: StateMachine

func enter(from: State):
	pass

func exit(to: State):
	pass


func handle_input(event: InputEvent) -> void:
	pass


func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	pass
