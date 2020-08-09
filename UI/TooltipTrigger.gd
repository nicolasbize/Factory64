extends Control

enum {DEFAULT, HOVER, PRESS}
var state = DEFAULT
var ui = null

export(String, MULTILINE) var tooltip_text

func _ready():
	ui = get_tree().current_scene.find_node("UI")

func _on_TooltipTrigger_mouse_entered():
	state = HOVER

func _on_TooltipTrigger_mouse_exited():
	state = DEFAULT
	ui.hide_tooltip()

func _on_TooltipTrigger_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and state == HOVER and event.button_index == BUTTON_RIGHT:
			state = PRESS
		elif event.pressed == false and state == PRESS and event.button_index == BUTTON_RIGHT:
			state = HOVER
			ui.show_tooltip(tooltip_text)
