## Dictionary of all the tiles in the world
## Autoloaded
extends Node

#var tiles: Dictionary = {}
var tiles: Array = []

# tile ids are cell numbers (8x8 cells)

func init() -> void:
	for x in range(50):
		var col = []
		col.resize(50)
		tiles.append(col)

func reset() -> void:
	pass
#	for tile in tiles.values():
#		tile.queue_free()
#	tiles = {}

func add(tile: Tile, position: Vector2) -> void:
#	var tile_id := get_id(position)
#	if tiles.has(tile_id):
#		return
#	tiles[tile_id] = tile
	var pos := (position / 8).floor()
	if tiles[pos.x][pos.y] != null:
		return
	tiles[pos.x][pos.y] = tile
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

func rotate(position: Vector2, angle: int) -> void:
#	var tile_id := get_id(position)
#	if tiles.has(tile_id):
#		var tile : Tile = tiles[tile_id]
#		tile.rotate(angle)
#		# rotate all the objects contained within the tile as well
#		WorldObjects.rotate_tile_contents(position, angle)
	var pos := (position / 8).floor()
	if tiles[pos.x][pos.y] != null:
		tiles[pos.x][pos.y].rotate(angle)
		# rotate all the objects contained within the tile as well
		WorldObjects.rotate_tile_contents(position, angle)

func reverse(position: Vector2) -> void:
#	var tile_id := get_id(position)
#	if tiles.has(tile_id):
#		var tile : Tile = tiles[tile_id]
#		tile.reverse()
	var pos := (position / 8).floor()
	if tiles[pos.x][pos.y] != null:
		tiles[pos.x][pos.y].reverse()
		
#func get_id(position: Vector2) -> String:
#	return str(floor(position.x / 8)) + "," + str(floor(position.y / 8))

func get_at(position: Vector2) -> Tile:
	var pos := (position / 8).floor()
	return tiles[pos.x][pos.y]
#	var id := get_id(position)
#	if tiles.has(id):
#		return tiles[id]
#	else:
#		return null

func can_add(position: Vector2) -> bool:
	return get_at(position) == null
#	return not tiles.has(get_id(position))

func destroy(tile: Tile) -> void:
#	var id := get_id(tile.global_position)
#	tiles.erase(id)
	var pos := (tile.global_position / 8).floor()
	tiles[pos.x][pos.y] = null
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
	
