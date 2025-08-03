extends Label

const result_text: = "You recovered\n [x] / 7 Holy Relics"

func _ready():
	var score = request_player_score()
	text = result_text.replace("[x]", str(score))


func request_player_score() -> int:
	return Global.load_player_score()
