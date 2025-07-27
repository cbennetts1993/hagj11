extends Node

signal register_local_player

var player: Player

func emit_register_local_player(player: Player):
	self.player = player
	register_local_player.emit(player)
