## Base class for conveyor belts
class_name BaseConveyorTile
extends "res://Tiles/Tile.gd"

onready var global_belt_timer := $"/root/GlobalBeltTimer"
onready var valid_area := $ValidArea

var is_anim_playing := false
var is_reverse := false
var flow_areas := []

func _ready() -> void:
	if global_belt_timer.connect("timeout", self, "_on_global_belt_timer") != OK:
		push_error("Tile could not subscribe to global timer event")
	
func _on_global_belt_timer() -> void:
	is_anim_playing = true
	global_belt_timer.disconnect("timeout", self, "_on_global_belt_timer")

func _on_TileTimer_timeout() -> void:
	move_objects()
	tile_timer.start(speed)

func move_objects() -> void:
	for flow in flow_areas:
		flow.move_objects()

func reverse() -> void:
	is_reverse = !is_reverse
	for flow in flow_areas:
		flow.reverse()

func is_valid_obj_pos(pos: Vector2) -> bool:
	var global_area: PoolVector2Array = global_transform.xform(valid_area.polygon)
	return Geometry.is_point_in_polygon(pos, global_area)
