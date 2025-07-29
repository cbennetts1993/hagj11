class_name ProjectileSpawner extends Node3D

@export var throw_speed: float = 10.0
@export var owner_hit_box: HitBox


func spawn_from_item(item: ItemData) -> void:
	var projectile = Projectile.create(item.sprite, item.world_scale, [owner_hit_box])
	add_child(projectile)
	
	projectile.top_level = true
	projectile.global_position = self.global_position
	#projectile.add_constant_force(-global_basis.z * throw_speed)
	projectile.apply_impulse(-global_basis.z * throw_speed)
