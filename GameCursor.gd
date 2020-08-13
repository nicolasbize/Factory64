## Custom game cursor
class_name GameCursor
extends CanvasLayer

const default_cursor := preload("res://UI/cursor.png")
const grab_cursor := preload("res://UI/grab-cursor.png")

onready var sprite := $Sprite

export (bool) var is_pixel_perfect_mouse = true

var is_dragging := false

func _process(_delta: float) -> void:
	# chop on purpose
	var p = get_viewport().get_mouse_position()
	if is_pixel_perfect_mouse:
		sprite.global_position = Vector2(floor(p.x), floor(p.y))
	else:
		sprite.global_position = p	
			
	if Input.is_action_just_pressed("drag"):
		is_dragging = true
		sprite.texture = grab_cursor
	if Input.is_action_just_released("drag"):	
		is_dragging = false
		sprite.texture = default_cursor
		
