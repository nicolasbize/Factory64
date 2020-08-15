extends CanvasLayer

onready var button_animator := $ButtonAnimator
onready var help := $MainPanel
onready var screens := $MainPanel/Background/Screens

var current_screen := 0
var hidden_pos := Vector2(-500,7)
var shown_pos := Vector2(6, 7)

func hide():
	help.rect_position = hidden_pos
	
func _on_LeftButton_click(el: ClickableButton) -> void:
	current_screen -= 1
	if current_screen < 0:
		current_screen = 0
	refresh()
	
func refresh() -> void:
	for screen in screens.get_children():
		screen.visible = false
	screens.get_child(current_screen).visible = true

func _on_RightButton_click(el: ClickableButton) -> void:
	next_screen()

func next_screen() -> void:
	current_screen += 1
	if current_screen > screens.get_child_count() - 1:
		current_screen = screens.get_child_count() - 1
	refresh()

func _on_HelpButton_click(el):
	if help.rect_position.x < 0:
		help.rect_position = shown_pos
	else:
		help.rect_position = hidden_pos

func _on_MainPanel_gui_input(event) -> void:
	if event is InputEventMouseButton and event.pressed:
		if screens.get_child(current_screen).hide_on_click:
			yield(get_tree().create_timer(0.1), "timeout")
			help.rect_position = hidden_pos
			next_screen()
		else:
			next_screen()

func _on_Timer_timeout() -> void:
	var shown : bool = help.rect_position == shown_pos
	if shown:
		button_animator.stop(true)
	else:
		button_animator.play("Blink")
	GameState.tutorial_focused = shown

func _on_MainMenuButton_click(el):
	help.rect_position = hidden_pos
