class_name Enemy extends CharacterBody3D

@onready var state_machine: StateMachine = %StateMachine
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var movement_component: MovementComponent = %MovementComponent


@export var enabled: bool = true

func _ready():
	if not enabled:
		disable_state_machine()


func enable_state_machine() -> void:
	state_machine.activate()

func disable_state_machine() -> void:
	state_machine.deactivate()
