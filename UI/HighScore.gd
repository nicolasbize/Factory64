extends Control

onready var time_taken := $TimeTaken

func _ready():
	GameState.connect("game_won", self, "on_game_won")
	
func on_game_won() -> void:
	var nb_years := GameState.months_taken / 12
	var nb_months := GameState.months_taken - nb_years * 12
	time_taken.text = "Score: %dy %dm" % [nb_years, nb_months]
