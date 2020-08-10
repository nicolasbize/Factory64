## Custom game cursor
class_name CustomCursor
extends Sprite

const default_cursor := preload("res://UI/cursor.png")
const grab_cursor := preload("res://UI/grab-cursor.png")
const help_cursor := preload("res://UI/cursor-help.png")

var is_dragging := false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("drag"):
		is_dragging = true
		texture = grab_cursor
	if Input.is_action_just_released("drag"):	
		is_dragging = false
		texture = default_cursor
		
func set_help() -> void:
	texture = help_cursor

func leave_help() -> void:
	texture = default_cursor
