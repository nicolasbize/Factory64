extends "res://Tiles/Tile.gd"

enum { FORWARD, BACKWARD }
var direction = FORWARD

onready var area_right = $AreaRight
onready var flow_right = $AreaRight/FlowRight
onready var valid_area = $ValidArea

func _process(delta):
	animationPlayer.play("Enabled-R")
	sprite.scale.x = 1 if direction == FORWARD else -1
	
func reverse():
	direction += 1
	if direction > 1:
		direction = 0

func is_valid_obj_pos(pos):
	var global_area = global_transform.xform(valid_area.polygon)
	if Geometry.is_point_in_polygon(pos, global_area):
		return true

func _on_TileTimer_timeout():
	move_objects()
	tile_timer.start(speed)

func move_objects():
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
