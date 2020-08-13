## An area that triggers and alters the help panel
class_name TooltipTrigger
extends Control

enum Status {DEFAULT, HOVER, PRESS}

export(String, MULTILINE) var tooltip_text

var state : int = Status.DEFAULT
var ui : TopUI = null

func _ready() -> void:
	ui = get_tree().current_scene.find_node("TopUI")

func _on_TooltipTrigger_mouse_entered() -> void:
	if tooltip_text != "":
		state = Status.HOVER

func _on_TooltipTrigger_mouse_exited() -> void:
	state = Status.DEFAULT
	ui.hide_tooltip()

func _on_TooltipTrigger_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and state == Status.HOVER and event.button_index == BUTTON_RIGHT:
			state = Status.PRESS
		elif event.pressed == false and state == Status.PRESS and event.button_index == BUTTON_RIGHT:
			state = Status.HOVER
			ui.show_tooltip(tooltip_text)
