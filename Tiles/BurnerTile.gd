extends "res://Tiles/Tile.gd"

onready var valid_area = $ValidArea
onready var storage_area = $StorageArea
onready var burn_timer = $BurnTimer

var max_item_count = 10
var currently_burning = null
export (int) var burn_speed = 5

# IRON_ORE, SILVER_ORE, SILICON_ORE, GOLD_ORE
var contents = [0, 0, 0, 0]

enum {DISABLED, PENDING, LIGHTUP, BURNING, LIGHTDOWN }
var status = PENDING

func _process(delta):
	if status == PENDING:
		animationPlayer.play("Pending")
	elif status == LIGHTUP:
		animationPlayer.play("LightUp")
	elif status == LIGHTDOWN:
		animationPlayer.play("LightDown")
	elif status == BURNING:
		animationPlayer.play("Burn")

func is_valid_obj_pos(pos):
	var global_area = global_transform.xform(valid_area.polygon)
	if Geometry.is_point_in_polygon(pos, global_area):
		return true

func _on_TileTimer_timeout():
	if status == PENDING:
		store_contents()
	var type_to_burn = contents.find(max_item_count)
	if type_to_burn > -1:
		contents[type_to_burn] = 0
		currently_burning = type_to_burn
		status = LIGHTUP
	
func store_contents():
	var items = storage_area.get_overlapping_areas()
	for item in items:
		if item != self:
			if item.type == null or item.type > Constants.ObjectType.GOLD_ORE:
				destroy(item)
			elif contents[item.type] < max_item_count:
				contents[item.type] += 1
				destroy(item)

func destroy(item):
	item.queue_free()
	WorldObjects.destroy(item)

func _on_LightUp_done():
	status = BURNING
	# TODO: Create plate
	currently_burning = null
	burn_timer.start(burn_speed)

func _on_LightDown_done():
	status = PENDING

func _on_BurnTimer_timeout():
	status = LIGHTDOWN
