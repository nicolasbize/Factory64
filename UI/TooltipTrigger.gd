extends Control

enum {DEFAULT, HOVER, PRESS}
var state = DEFAULT
var ui = null
var cursor = null

export(String, MULTILINE) var tooltip_text

func _ready():
	ui = get_tree().current_scene.find_node("UI")
	cursor = ui.find_node("CustomCursor")

func _on_TooltipTrigger_mouse_entered():
	if tooltip_text != "":
		state = HOVER
		cursor.set_help()

func _on_TooltipTrigger_mouse_exited():
	if tooltip_text != "":
		state = DEFAULT
		ui.hide_tooltip()
		cursor.leave_help()

func _on_TooltipTrigger_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and state == HOVER and event.button_index == BUTTON_RIGHT:
			state = PRESS
		elif event.pressed == false and state == PRESS and event.button_index == BUTTON_RIGHT:
			state = HOVER
			ui.show_tooltip(tooltip_text)
