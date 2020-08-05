extends "res://Tiles/Belts/BaseConveyorTile.gd"


onready var storage_area = $StorageArea
onready var process_timer = $ProcessTimer

var max_item_count = 10
var currently_processing = null
var currently_stored = null
export (int) var process_speed = 5

# IRON_ORE, SILVER_ORE, SILICON_ORE, GOLD_ORE
var contents = [0, 0, 0, 0]

enum {PENDING, POWERUP, BUSY, POWERDOWN }
var status = PENDING

func _process(delta):
	if status == PENDING:
		animationPlayer.play("Pending")
	elif status == POWERUP:
		animationPlayer.play("PowerUp")
	elif status == POWERDOWN:
		animationPlayer.play("PowerDown")
	elif status == BUSY:
		animationPlayer.play("Busy")

func _on_TileTimer_timeout():
	if status == PENDING:
		store_contents()

	if currently_stored != null:
		# can we dispose of it?
		var spot = get_next_open_spot()
		if spot != null:
			var item = create_item_from_ore(currently_stored)
			expulse(item, spot)
	else:
		# do we have enough items to process?
		var type_to_process = contents.find(max_item_count)
		if type_to_process > -1:
			contents[type_to_process] = 0
			currently_processing = type_to_process
			status = POWERUP

func get_next_open_spot():
	var target_tile = null
	var spot = null
	if direction == Facing.RIGHT:
		spot = global_position + Vector2.RIGHT * 4
	elif direction == Facing.LEFT:
		spot = global_position + Vector2.LEFT * 4
	elif direction == Facing.UP:
		spot = global_position + Vector2.UP * 4
	else:
		spot = global_position + Vector2.DOWN * 4	
	target_tile = WorldTiles.get_at(spot)
	if target_tile != null and target_tile.is_valid_obj_pos(spot) and not WorldObjects.has_at(spot):
		return spot
	else:
		return null

func create_item_from_ore(ore_type):
	print("parent class needs to instantiate item")
	return null
	
func expulse(item, pos):
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(item)
	item.global_position = pos
	WorldObjects.add(item, pos)
	currently_stored = null

func store_contents():
	var items = storage_area.get_overlapping_areas()
	for item in items:
		if item != self:
			# destroy non-ore items
			if item.type == null or item.type > Constants.ObjectType.GOLD_ORE:
				destroy(item)
			elif contents[item.type] < max_item_count:
				contents[item.type] += 1
				destroy(item)

func destroy(item):
	item.queue_free()
	WorldObjects.destroy(item)

func _on_PowerUp_done():
	status = BUSY
	process_timer.start(process_speed)

func _on_PowerDown_done():
	status = PENDING
	currently_stored = currently_processing
	currently_processing = null

func _on_ProcessTimer_timeout():
	status = POWERDOWN
	process_timer.stop()
