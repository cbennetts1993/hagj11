class_name VisionComponent extends Node3D

@export_flags_3d_physics var collision_mask

## Dot product threshold for vision. a threshold of 0 would mean that an object is in sight in
## a 180 degree cone in front of the vision component. A threshold of -1 would mean visibility in all directions.
@export_range(-1, 1, 0.1) var vision_angle: float

@onready var vision_area: Area3D = %Area3D
@onready var vision_ray: RayCast3D = %RayCast3D

func get_visible_nodes() -> Array[Node3D]:
	return vision_area.get_overlapping_bodies()

func is_node_in_vision_radius(node: Node3D) -> bool:
	return get_visible_nodes().has(node) 


func is_node_in_vision_cone(node: Node3D) -> bool:
	var my_facing = self.global_transform.basis.z
	var player_direction = self.global_position.direction_to(node.global_position)
	var dot = my_facing.dot(player_direction)
	return dot > vision_angle

func is_node_in_line_of_sight(node: Node3D) -> bool:
	return vision_ray.is_colliding() and vision_ray.get_collider() == node
	
	#var space = get_world_3d().direct_space_state
	#var query: = PhysicsRayQueryParameters3D.new()
	#query.from = self.global_position
	#query.to = node.global_position
	#query.collision_mask = collision_mask
	#var result = space.intersect_ray(query)
	#return result and result.collider == node

func is_node_visible(node: Node3D) -> bool:
	return is_node_in_vision_cone(node) and is_node_in_line_of_sight(node)
