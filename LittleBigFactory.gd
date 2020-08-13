extends Node

onready var intro_canvas := $IntroCanvas
onready var world := $World

func _on_NewGameButton_click(el):
	yield(get_tree().create_timer(0.3), "timeout")
	start_game()

func start_game():
	intro_canvas.queue_free()
	world.start()
