extends TextureRect

enum {DEFAULT, HOVER, PRESS}
var state = DEFAULT

export (bool) var move_on_click = true

signal click(el)

func _on_ClickableButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and state == HOVER:
			if move_on_click:
				rect_global_position.y += 1
			state = PRESS
		elif event.pressed == false and state == PRESS:
			if move_on_click:
				rect_global_position.y -= 1
			state = HOVER
			emit_signal("click", self)

func _on_ClickableButton_mouse_entered():
	state = HOVER

func _on_ClickableButton_mouse_exited():
	if state == PRESS and move_on_click:
		rect_global_position.y -= 1
	state = DEFAULT
