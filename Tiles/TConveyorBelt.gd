extends "res://Tiles/Tile.gd"

enum { RIGHT, TOP, DOWN }
var direction = RIGHT

onready var area_down = $AreaDown
onready var area_top = $AreaTop
onready var area_right = $AreaRight
onready var valid_area = $ValidArea

func _process(delta):
	if direction == RIGHT:
		animationPlayer.play("Enabled-R")
	elif direction == TOP:
		animationPlayer.play("Enabled-T")
	else:
		animationPlayer.play("Enabled-D")

func reverse():
	direction += 1
	if direction > 2:
		direction = 0

func _on_TileTimer_timeout():
	move_objects()
	tile_timer.start(speed)

func move_objects():
	for obj in area_right.get_overlapping_areas():
		if obj != area_right:
			var movement = Vector2.ZERO
			if direction == RIGHT:
				movement.x += 1
			else:
				movement.x -= 1
			movement = movement.rotated(rotation)
			var new_loc = obj.global_position + movement
			WorldObjects.move(obj, new_loc)
	for obj in area_down.get_overlapping_areas():
		if obj != area_down:
			var movement = Vector2.ZERO
			if direction == RIGHT or direction == DOWN:
				movement.y += 1
			else:
				movement.y -= 1
			movement = movement.rotated(rotation)
			var new_loc = obj.global_position + movement
			WorldObjects.move(obj, new_loc)
	for obj in area_top.get_overlapping_areas():
		if obj != area_down:
			var movement = Vector2.ZERO
			if direction == RIGHT or direction == TOP:
				movement.y -= 1
			else:
				movement.y += 1
			movement = movement.rotated(rotation)
			var new_loc = obj.global_position + movement
			WorldObjects.move(obj, new_loc)
		
func is_valid_obj_pos(pos):
	var global_area = global_transform.xform(valid_area.polygon)
	if Geometry.is_point_in_polygon(pos, global_area):
		return true
	
