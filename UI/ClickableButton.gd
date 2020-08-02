extends TextureRect

enum {DEFAULT, HOVER, PRESS}
var state = DEFAULT

signal click

func _on_ClickableButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and state == HOVER:
			rect_global_position.y += 1
			state = PRESS
		elif event.pressed == false and state == PRESS:
			rect_global_position.y -= 1
			state = HOVER
			emit_signal("click")

func _on_ClickableButton_mouse_entered():
	state = HOVER

func _on_ClickableButton_mouse_exited():
	if state == PRESS:
		rect_global_position.y -= 1
	state = DEFAULT
