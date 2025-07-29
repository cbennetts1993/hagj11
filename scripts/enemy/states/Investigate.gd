extends State

@export var blackboard: Blackboard

@export var vision: VisionComponent
@export var movement: MovementComponent
@export var navigation: NavigationAgent3D

@export var idle_state: State
@export var follow_state: State

func enter(from: State):
	navigation.target_position = blackboard.investigate_location


func update(delta: float) -> void:
	if blackboard.has_been_investigated:
		state_machine.change_state(idle_state)
		return
	
	if movement.body.global_position.distance_to(blackboard.investigate_location) <= 0.1:
		state_machine.change_state(idle_state)
		blackboard.has_been_investigated = true
		return
	
	if vision.is_node_visible(blackboard.player):
		state_machine.change_state(follow_state)
		return


func physics_update(delta: float) -> void:
	var navigation_path_target = navigation.get_next_path_position()
	var direction = movement.body.global_position.direction_to(navigation_path_target)
	movement.move(direction)
	movement.apply_gravity()
