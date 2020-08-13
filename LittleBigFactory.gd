extends Node

onready var high_score := $IntroCanvas/HighScore
onready var main_menu := $IntroCanvas/MainMenu
onready var world := $World

func _on_NewGameButton_click(el: ClickableButton) -> void:
	yield(get_tree().create_timer(0.3), "timeout")
	start_game()

func start_game() -> void:
	main_menu.hide()
	world.start()
	GameState.connect("game_won", self, "on_game_win")
	
func on_game_win() -> void:
	yield(get_tree().create_timer(1), "timeout")
	world.queue_free()
	high_score.show()
