extends EnemyCommand

var animation: String

func _init( _animation: String ) -> void:
	animation = _animation


func execute( actor: Enemy, data: Object = null ) -> bool:
	
	actor.animation_player.play(animation)
	
	if actor.animation_player.is_playing():
		return false
	
	completed.emit()
	return true
