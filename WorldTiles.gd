extends Node

var tiles = {}
# tile ids are cell numbers (8x8 cells)

func add(tile, position):
	var tile_id = get_id(position)
	if tiles.has(tile_id):
#		print("cannot place tile, spot already taken")
		pass
	tiles[tile_id] = tile
#	print("adding tile with id " + tile_id)

func rotate(position, angle):
	var tile_id = get_id(position)
	if tiles.has(tile_id):
		var tile = tiles[tile_id]
		tile.rotate(angle)
		
		# rotate all the objects contained within the tile as well
		WorldObjects.rotate_tile_contents(position, angle)
#		print("tile angle: " + str(rad2deg(tile.rotation)))

func reverse(position):
	var tile_id = get_id(position)
	if tiles.has(tile_id):
		var tile = tiles[tile_id]
		tile.reverse()

func get_id(position):
	return str(floor(position.x / 8)) + "," + str(floor(position.y / 8))

func get_at(position):
	var id = get_id(position)
	if tiles.has(id):
		return tiles[id]
	else:
#		print("could not find tile: " + str(tiles.keys()))
		return null

func can_add(position):
	return not tiles.has(get_id(position))
