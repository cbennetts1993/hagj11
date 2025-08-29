class_name State extends Node
## Basic state for a state machine

signal entered
signal exited

@export var state_machine: StateMachine

func enter(_from: State) -> void:
	pass

func exit(_to: State) -> void:
	pass


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
