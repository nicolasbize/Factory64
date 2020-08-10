## An area that moves objects along in a specific direction
class_name Flow
extends Area2D

onready var flow_area := $FlowArea

var is_reverse := false

func reverse() -> void:
	is_reverse = !is_reverse

func move_objects() -> void:
	for obj in get_overlapping_areas():
		if obj != self:
			var movement := Vector2.LEFT if is_reverse else Vector2.RIGHT
			movement = movement.rotated(global_rotation)
			var new_loc : Vector2 = obj.global_position + movement
			new_loc = Vector2(round(new_loc.x), round(new_loc.y))
			
			if WorldObjects.try_move(obj, new_loc):
				obj.global_position = new_loc
