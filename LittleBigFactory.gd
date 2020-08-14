extends Node

onready var high_score := $IntroCanvas/HighScore
onready var main_menu := $IntroCanvas/MainMenu
onready var tutorial_menu := $Tutorial/TopMenu
onready var tutorial_contents := $Tutorial/MainPanel
onready var world := $World

func _on_NewGameButton_click(el: ClickableButton) -> void:
	yield(get_tree().create_timer(0.3), "timeout")
	start_game()

func start_game() -> void:
	tutorial_menu.hide()
	tutorial_contents.hide()
	main_menu.hide()
	world.start()
	GameState.connect("game_won", self, "on_game_win")
	
func on_game_win() -> void:
	yield(get_tree().create_timer(1), "timeout")
	world.queue_free()
	high_score.show()

func _on_TutorialButton_click(el):
	main_menu.hide()
	world.start()
	tutorial_menu.show()
	tutorial_contents.show()

func _on_RestartGameButton_click(el):
	main_menu.show()
	tutorial_menu.hide()
	tutorial_contents.hide()
	GameState.reset()
	
