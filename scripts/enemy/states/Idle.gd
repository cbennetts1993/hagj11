extends State

@export var blackboard: Blackboard

@export var vision: VisionComponent
@export var movement: MovementComponent

@export var wander_timer: Timer
@export var wander_state: State

@export var follow_state: State
@export var patrol_state: State
@export var investigate_state: State


@export var animation_name: String = "idle"
@export var animation_front: AnimatedSprite3D
@export var animation_back: AnimatedSprite3D

func enter(from: State):
	wander_timer.start()
	
	animation_front.animation = animation_name
	animation_back.animation = animation_name


func update(delta: float):
	
	if vision.is_node_visible(blackboard.player):
		state_machine.change_state(follow_state)
		return
	
	if not blackboard.has_been_investigated:
		state_machine.change_state(investigate_state)
		return
	
	if wander_timer.is_stopped():
		if patrol_state and patrol_state.is_valid():
			state_machine.change_state(patrol_state)
			return
		else:
			state_machine.change_state(wander_state)
		return
	

func physics_update(delta: float) -> void:
	movement.apply_gravity()
