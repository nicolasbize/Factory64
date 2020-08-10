extends Node

var objects := {}

func add(obj: MovableObject, position: Vector2) -> void:
	var id := get_id(position)
	if objects.has(id):
		pass
	objects[id] = obj

func get_id(position: Vector2) -> String:
	return str(position.x) + "," + str(position.y)

func has_at(position: Vector2) -> bool:
	return objects.has(get_id(position))

func get_at(position: Vector2) -> MovableObject:
	if has_at(position):
		return objects[get_id(position)]
	else:
		return null

func id_to_pos(id: String) -> Vector2:
	var parts := id.split(",")
	return Vector2(int(parts[0]), int(parts[1]))

func can_move(obj: MovableObject, new_pos: Vector2) -> bool:
	var movement = new_pos - obj.global_position
	var next_ids = [get_id(new_pos)]
	if obj.type > Constants.ObjectType.GOLD_ORE:
		next_ids.append(get_id(new_pos + movement))
	for next_id in next_ids:
		if objects.has(next_id):
			return false

#	var next_id := get_id(new_pos)
#	# can't move if an object exists there
#	if objects.has(next_id):
#		return false
	# can't move there if the tile isn't accepting it
	var tile := WorldTiles.get_at(new_pos)
	if tile == null:
#		print("can't move to " + str(new_pos) + ", no tile to accept me at " + WorldTiles.get_id(new_pos))
		return false
	return tile.is_valid_obj_pos(new_pos)

# check if there are other moveable objects where we want to go
func try_move(obj: MovableObject, new_pos: Vector2) -> bool:
	if can_move(obj, new_pos):
		var id := get_id(obj.global_position)
		var new_id := get_id(new_pos)
		if objects.has(id):
			objects.erase(id)
			objects[new_id] = obj
		return true
	else:
		return false
#			print("moved " + id + " to " + new_id)

func destroy(obj: MovableObject) -> void:
	var id = get_id(obj.global_position)
	if objects.has(id):
		objects.erase(id)

func rotate_tile_contents(position: Vector2, angle: float) -> void:
	# find all the objects within this tile
	var pivot := position + Vector2(4, 4)
	var objects_to_rotate := []
	for x in range(pivot.x - 4, pivot.x + 4):
		for y in range(pivot.y - 4, pivot.y + 4):
			var id := get_id(Vector2(x, y))
			if objects.has(id):
				objects_to_rotate.append(objects[id])
				objects.erase(id)
	for obj in objects_to_rotate:
		# to do a perfect rotation we need to set the pivot to the center of the pixel
		var rotation : Vector2 = (obj.global_position - pivot + Vector2(0.5, 0.5)).rotated(deg2rad(angle))
		var new_pos := rotation + pivot
		obj.global_position = new_pos - Vector2(0.5, 0.5)
		objects[get_id(obj.global_position)] = obj
	
