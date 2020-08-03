extends "res://Tiles/Tile.gd"

enum { FORWARD, BACKWARD }
var direction = FORWARD

onready var area_down = $AreaDown
onready var area_right = $AreaRight
onready var valid_area_right = $ValidAreaRight
onready var valid_area_top = $ValidAreaTop
onready var valid_area_bottom = $ValidAreaBottom
onready var valid_area_left = $ValidAreaLeft

onready var valid_areas = [valid_area_right, valid_area_bottom, valid_area_left, valid_area_top]
var current_valid_area_index = 0

func _physics_process(delta):
	animationPlayer.play("Enabled-R" if direction == FORWARD else "Enabled-T")

func reverse():
	direction += 1
	if direction > 1:
		direction = 0

func rotate(angle):
	.rotate(angle)
	if angle < 0:
		current_valid_area_index -= 1
		if current_valid_area_index < 0:
			current_valid_area_index = 3
	else:
		current_valid_area_index += 1
		if current_valid_area_index > 3:
			current_valid_area_index = 0

func _on_TileTimer_timeout():
	move_objects()
	tile_timer.start(speed)

func move_objects():
	for obj in area_down.get_overlapping_areas():
		if obj != area_down:
			var movement = Vector2.ZERO
			if direction == FORWARD:
				movement.y += 1
			else:
				movement.y -= 1
			movement = movement.rotated(rotation)
			var new_loc = obj.global_position + movement
			WorldObjects.move(obj, new_loc)
	for obj in area_right.get_overlapping_areas():
		if obj != area_right:
			var movement = Vector2.ZERO
			if direction == FORWARD:
				movement.x += 1
			else:
				movement.x -= 1
			movement = movement.rotated(rotation)
			var new_loc = obj.global_position + movement
			WorldObjects.move(obj, new_loc)
		
func is_valid_obj_pos(pos):
	var valid_area = valid_areas[current_valid_area_index]
	var global_area = global_transform.xform(valid_area.polygon)
	if Geometry.is_point_in_polygon(pos, global_area):
		return true

