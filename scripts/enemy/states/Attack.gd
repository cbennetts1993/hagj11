extends State

@export var animation: StringName
@export var attack_speed: float = 1.0
@export var animation_player: AnimationPlayer
@export var movement: MovementComponent

var return_state: State

@export var animation_name: String = "idle"
@export var animation_front: AnimatedSprite3D
@export var animation_back: AnimatedSprite3D



func enter(from: State):
	return_state = from
	animation_player.play(animation, -1, attack_speed)
	
	animation_front.animation = animation_name
	animation_back.animation = animation_name



func update(delta: float):
	if not animation_player.is_playing():
		state_machine.change_state(return_state)
		return
