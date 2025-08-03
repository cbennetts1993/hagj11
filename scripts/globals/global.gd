extends Node

signal register_local_player

var player: Player

func emit_register_local_player(player: Player):
	self.player = player
	register_local_player.emit(player)


var player_score: int = 0

func load_player_score() -> int:
	return player_score

func update_player_score(score: int) -> void:
	player_score = score


var relic_array: Array[ItemData] = [
	preload("res://media/items/ifflaed_of_whitby_mssedi_with_st_cuthbert/lfflaed_Of_Whitby_Mssedi_With_St._Cuthbert.tres"),
	preload("res://media/items/manifldlice_medicinal_herbes/Manifldlice_Medicinal_Herbes.tres"),
	preload("res://media/items/name_stone/Name_Stone.tres"),
	preload("res://media/items/te_deum_sheet_music/Te_Deum_Sheet_Music.tres"),
	preload("res://media/items/the_anonymous_life_of_st._cuthbert/The_Anonymous_Life_Of_St._Cuthbert.tres"),
	preload("res://media/items/vita_sancti_martini/Vita_Sancti_Martini.tres"),
	preload("res://media/items/Lindisfarne_Gospels_ChiRo/lindisfarne_gospels_chiro.tres")
]


func compare_relic_array(from: Array[ItemData]) -> int:
	var count: int = 0
	for x in relic_array:
		if from.has(x):
			count += 1
	return count


signal play_dialogue(text: String, duration: float)

func emit_trigger_dialogue(text: String, duration: float = 1.0):
	play_dialogue.emit(text, duration)
