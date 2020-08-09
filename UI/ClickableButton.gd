extends TextureRect

enum {DEFAULT, HOVER, PRESS}
var state = DEFAULT

export (bool) var move_on_click = true
export (bool) var disabled = false

signal click(el)

func _ready():
	if disabled:
		disable()
		
func disable():
	var mat = get_material()
	mat.set_shader_param("grayscale", true)
	disabled = true

func enable():
	var mat = get_material()
	mat.set_shader_param("grayscale", false)
	disabled = false

func _on_ClickableButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and state == HOVER and event.button_index == BUTTON_LEFT:
			if move_on_click:
				rect_global_position.y += 1
			state = PRESS
		elif event.pressed == false and state == PRESS and event.button_index == BUTTON_LEFT:
			if move_on_click:
				rect_global_position.y -= 1
			state = HOVER
			if not disabled:
				emit_signal("click", self)

func _on_ClickableButton_mouse_entered():
	state = HOVER

func _on_ClickableButton_mouse_exited():
	if state == PRESS and move_on_click and not disabled:
		rect_global_position.y -= 1
	state = DEFAULT
