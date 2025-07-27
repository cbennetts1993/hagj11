extends State

@export var animation: StringName
@export var move_speed_modifier: float = 1.0

@export_group("Components")
@export var animation_player: AnimationPlayer
@export var movement: MovementComponent
@export var crouch_collider: CollisionShape3D
@export var input: InputComponent

@export_group("States")
@export var stand_state: State

func enter(from: State) -> void:
	animation_player.play(animation)
	movement.set_speed_multiplier(move_speed_modifier)


func update(delta: float) -> void:
	
	if not input.is_crouch_pressed() and can_stand():
		state_machine.change_state(stand_state)
		return


func can_stand() -> bool:
	var space = crouch_collider.get_world_3d().direct_space_state
	var query = PhysicsShapeQueryParameters3D.new()
	query.shape = crouch_collider.shape
	query.collide_with_bodies = true
	query.collision_mask = 1
	
	var transform = crouch_collider.global_transform
	transform.origin += Vector3.UP
	query.transform = transform
	
	return space.intersect_shape(query).is_empty()
