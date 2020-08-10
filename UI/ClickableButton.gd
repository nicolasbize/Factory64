## Simple button that can move down when clicked
class_name ClickableButton
extends TextureRect

enum State {DEFAULT, HOVER, PRESS}

export (bool) var move_on_click = true
export (bool) var disabled = false

var state = State.DEFAULT

signal click(el)

func _ready() -> void:
	if disabled:
		disable()
		
func disable() -> void:
	var mat = get_material()
	mat.set_shader_param("grayscale", true)
	disabled = true

func enable() -> void:
	var mat = get_material()
	mat.set_shader_param("grayscale", false)
	disabled = false

func _on_ClickableButton_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and state == State.HOVER and event.button_index == BUTTON_LEFT:
			if move_on_click:
				rect_global_position.y += 1
			state = State.PRESS
		elif event.pressed == false and state == State.PRESS and event.button_index == BUTTON_LEFT:
			if move_on_click:
				rect_global_position.y -= 1
			state = State.HOVER
			if not disabled:
				emit_signal("click", self)

func _on_ClickableButton_mouse_entered() -> void:
	state = State.HOVER

func _on_ClickableButton_mouse_exited() -> void:
	if state == State.PRESS and move_on_click and not disabled:
		rect_global_position.y -= 1
	state = State.DEFAULT
