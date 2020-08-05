extends "res://Tiles/Tile.gd"

#const SilverPlate = preload("res://Objects/SilverPlate.tscn")
#
#onready var valid_area = $ValidArea
#onready var storage_area = $StorageArea
#onready var burn_timer = $BurnTimer
#
#var max_item_count = 10
#var currently_burning = null
#var currently_stored = null
#export (int) var burn_speed = 5
#
## IRON_ORE, SILVER_ORE, SILICON_ORE, GOLD_ORE
#var contents = [0, 0, 0, 0]
#enum {TOP, RIGHT, BOTTOM, LEFT}
#var direction = TOP
#
#enum {DISABLED, PENDING, LIGHTUP, BURNING, LIGHTDOWN }
#var status = PENDING
#
#func _process(delta):
#	if status == PENDING:
#		animationPlayer.play("Pending")
#	elif status == LIGHTUP:
#		animationPlayer.play("LightUp")
#	elif status == LIGHTDOWN:
#		animationPlayer.play("LightDown")
#	elif status == BURNING:
#		animationPlayer.play("Burn")
#
#func rotate(angle):
#	.rotate(angle)
#	if angle > 0:
#		direction += 1
#		if direction > 3:
#			direction = 0
#	else:
#		direction -= 1
#		if direction < 0:
#			direction = 3
#
#func is_valid_obj_pos(pos):
#	var global_area = global_transform.xform(valid_area.polygon)
#	if Geometry.is_point_in_polygon(pos, global_area):
#		return true
#
#func _on_TileTimer_timeout():
#	if status == PENDING:
#		store_contents()
#
#	if currently_stored != null:
#		# can we dispose of it?
#		var spot = get_next_open_spot()
#		if spot != null:
#			var plate = create_plate_from_stored_item()
#			send_plate(plate, spot)
#	else:
#		# do we have 10 items and can we burn?
#		var type_to_burn = contents.find(max_item_count)
#		if type_to_burn > -1:
#			contents[type_to_burn] = 0
#			currently_burning = type_to_burn
#			status = LIGHTUP
#
#func get_next_open_spot():
#	var target_tile = null
#	var spot = null
#	if direction == RIGHT:
#		spot = global_position + Vector2.RIGHT * 4
#		target_tile = WorldTiles.get_at(spot)
#	if target_tile != null and target_tile.is_valid_obj_pos(spot) and not WorldObjects.has_at(spot):
#		return spot
#	else:
#		return null
#
#func create_plate_from_stored_item():
#	var plate = null
#	match currently_stored:
#		Constants.ObjectType.SILVER_ORE:
#			plate = SilverPlate.instance()
#			plate.set_type(Constants.ObjectType.SILVER_PLATE)
#	return plate
#
#func send_plate(plate, pos):
#	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
#	main.add_child(plate)
#	plate.global_position = pos
#	WorldObjects.add(plate, pos)
#	currently_stored = null
#
#func store_contents():
#	var items = storage_area.get_overlapping_areas()
#	for item in items:
#		if item != self:
#			# destroy non-ore items
#			if item.type == null or item.type > Constants.ObjectType.GOLD_ORE:
#				destroy(item)
#			elif contents[item.type] < max_item_count:
#				contents[item.type] += 1
#				destroy(item)
#
#func destroy(item):
#	item.queue_free()
#	WorldObjects.destroy(item)
#
#func _on_LightUp_done():
#	status = BURNING
#	burn_timer.start(burn_speed)
#
#func _on_LightDown_done():
#	status = PENDING
#	currently_stored = currently_burning
#	currently_burning = null
#
#func _on_BurnTimer_timeout():
#	status = LIGHTDOWN
#	burn_timer.stop()
