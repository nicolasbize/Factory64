## Custom game cursor
## AutoLoaded
extends Sprite

const default_cursor := preload("res://UI/cursor.png")
const grab_cursor := preload("res://UI/grab-cursor.png")

export (bool) var is_pixel_perfect_mouse = true

var is_dragging := false

func _process(_delta: float) -> void:
	# chop on purpose
	var p = get_viewport().get_mouse_position()
	if is_pixel_perfect_mouse:
		global_position = Vector2(floor(p.x), floor(p.y))
	else:
		global_position = p	
			
	if Input.is_action_just_pressed("drag"):
		is_dragging = true
		texture = grab_cursor
	if Input.is_action_just_released("drag"):	
		is_dragging = false
		texture = default_cursor
		
