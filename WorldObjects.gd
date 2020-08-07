extends Node

var objects = {}

func add(obj, position):
	var id = get_id(position)
	if objects.has(id):
#		print("cannot add object, spot already taken")
		pass
	objects[id] = obj
#	print("added object, listing keys:")
#	print(objects.keys())

func get_id(position):
	return str(position.x) + "," + str(position.y)

func has_at(position):
	return objects.has(get_id(position))

func get_at(position):
	if has_at(position):
		return objects[get_id(position)]
	else:
		return null

func id_to_pos(id):
	var parts = id.split(",")
	return Vector2(int(parts[0]), int(parts[1]))

func can_move(obj, new_pos):
	var next_id = get_id(new_pos)
	# can't move if an object exists there
	if objects.has(next_id):
#		print("can't move there, an object is already there")
#		print(get_id(obj.global_position))
#		print(next_id)
#		print("listing existing keys:")
#		print(objects.keys())
		return false
	# can't move there if the tile isn't accepting it
	var tile = WorldTiles.get_at(new_pos)
	if tile == null:
#		print("can't move to " + str(new_pos) + ", no tile to accept me at " + WorldTiles.get_id(new_pos))
		return false
	return tile.is_valid_obj_pos(new_pos)

# check if there are other moveable objects where we want to go
func try_move(obj, new_pos):
	if can_move(obj, new_pos):
		var id = get_id(obj.global_position)
		var new_id = get_id(new_pos)
		if objects.has(id):
			objects.erase(id)
			objects[new_id] = obj
			obj.global_position = id_to_pos(new_id)
#			print("moved " + id + " to " + new_id)

func destroy(obj):
	var id = get_id(obj.global_position)
	if objects.has(id):
		objects.erase(id)

func rotate_tile_contents(position, angle):
	# find all the objects within this tile
	var pivot = position + Vector2(4, 4)
	var objects_to_rotate = []
	for x in range(pivot.x - 4, pivot.x + 4):
		for y in range(pivot.y - 4, pivot.y + 4):
			var id = get_id(Vector2(x, y))
			if objects.has(id):
				objects_to_rotate.append(objects[id])
				objects.erase(id)
#	print("rotating " + str(objects_to_rotate.size()) + " objects around " + str(pivot) + " by " + str(angle) + " deg")
	for obj in objects_to_rotate:
		# to do a perfect rotation we need to set the pivot to the center of the pixel
		var rotation = (obj.global_position - pivot + Vector2(0.5, 0.5)).rotated(deg2rad(angle))
		var new_pos = rotation + pivot
		obj.global_position = new_pos - Vector2(0.5, 0.5)
#		print("new pos: " + str(obj.global_position))
		objects[get_id(obj.global_position)] = obj
	
