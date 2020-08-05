extends "res://Tiles/Tile.gd"

onready var global_belt_timer = $"/root/GlobalBeltTimer"
onready var valid_area = $ValidArea

var is_anim_playing = false
var is_reverse = false
var flow_areas = []

func _ready():
	global_belt_timer.connect("timeout", self, "_on_global_belt_timer")
	
func _on_global_belt_timer():
	is_anim_playing = true
	global_belt_timer.disconnect("timeout", self, "_on_global_belt_timer")

func _on_TileTimer_timeout():
	move_objects()
	tile_timer.start(speed)

func move_objects():
	for flow in flow_areas:
		flow.move_objects()

func reverse():
	is_reverse = !is_reverse
	for flow in flow_areas:
		flow.reverse()

func is_valid_obj_pos(pos):
	var global_area = global_transform.xform(valid_area.polygon)
	if Geometry.is_point_in_polygon(pos, global_area):
		return true
