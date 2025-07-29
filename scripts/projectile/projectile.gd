class_name Projectile extends RigidBody3D

const damage_shape_scene = preload("res://scripts/components/hitshapes/damage_shape.tscn")

static func create(sprite: Texture2D = null, sprite_scale: Vector3 = Vector3.ONE, exclude: Array[Area3D] = []) -> Projectile:
	var new = Projectile.new()
	new.contact_monitor = true
	new.max_contacts_reported = 1
	new.collision_mask = 1
	
	## Damage Shape
	var damage_shape = DamageShape.new()
	damage_shape.collision_mask = 8
	damage_shape.exclude = exclude
	new.add_child(damage_shape)
	
	var dmg_collision = CollisionShape3D.new()
	dmg_collision.shape = SphereShape3D.new()
	dmg_collision.shape.radius = 0.3
	damage_shape.add_child(dmg_collision)
	
	
	## Collision Shape
	var collision = CollisionShape3D.new()
	collision.shape = SphereShape3D.new()
	collision.shape.radius = 0.1
	new.add_child(collision)
	
	## Sprite
	var sprite3d = Sprite3D.new()
	sprite3d.texture = sprite
	sprite3d.scale = sprite_scale
	sprite3d.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	new.add_child(sprite3d)
	
	return new

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	print("Hit an object and broke!")
	print(body)
	queue_free()
