extends EnemyCommand

var target_position: Vector3

func _init( position: Vector3 ) -> void:
	target_position = position


func execute( actor: Enemy, data: Object = null ) -> bool:
	
	actor.animation_player.play("Walk")
	
	if actor.global_position.distance_to( target_position ) <= 1.0:
		completed.emit()
		return true
	
	var direction = actor.global_position.direction_to( target_position )
	var movement = actor.movement_component
	
	movement.move(direction)
	movement.rotate_to_direction(direction * Vector3(1, 0, 1))
	movement.apply_gravity()
	
	return false
