extends Sprite

onready var tooltip_timer = $TooltipTimer

const grab_cursor = preload("res://UI/grab-cursor.png")
const default_cursor = preload("res://UI/cursor.png")

var is_dragging = false

func _process(delta):
	if Input.is_action_just_pressed("drag"):
		is_dragging = true
		texture = grab_cursor
	if Input.is_action_just_released("drag"):	
		is_dragging = false
		texture = default_cursor
		
