extends Node

var tiles = {}
# tile ids are cell numbers (8x8 cells)

func add(tile, position):
	var tile_id = get_id(position)
	if tiles.has(tile_id):
		pass
	tiles[tile_id] = tile
	match tile.type:
		Constants.TileType.ASSEMBLY:
			GameState.nb_assemblies += 1
		Constants.TileType.CUTTER:
			GameState.nb_cutters += 1
		Constants.TileType.FACTORY:
			GameState.nb_factories += 1
		Constants.TileType.FURNACE:
			GameState.nb_burners += 1
		Constants.TileType.GOLD, Constants.TileType.IRON, Constants.TileType.SILICON, Constants.TileType.GOLD:
			GameState.nb_extractors += 1
		Constants.TileType.RESELLER:
			GameState.nb_sellers += 1

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

func destroy(tile):
	var id = get_id(tile.global_position)
	if tiles.has(id):
		tiles.erase(id)
	match tile.type:
		Constants.TileType.ASSEMBLY:
			GameState.nb_assemblies -= 1
		Constants.TileType.CUTTER:
			GameState.nb_cutters -= 1
		Constants.TileType.FACTORY:
			GameState.nb_factories -= 1
		Constants.TileType.FURNACE:
			GameState.nb_burners -= 1
		Constants.TileType.GOLD, Constants.TileType.IRON, Constants.TileType.SILICON, Constants.TileType.GOLD:
			GameState.nb_extractors -= 1
		Constants.TileType.RESELLER:
			GameState.nb_sellers -= 1
	
