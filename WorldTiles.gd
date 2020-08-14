## Dictionary of all the tiles in the world
## Autoloaded
extends Node

var tiles: Dictionary = {}
# tile ids are cell numbers (8x8 cells)

func reset() -> void:
	for tile in tiles.values():
		tile.queue_free()
	tiles = {}

func add(tile: Tile, position: Vector2) -> void:
	var tile_id := get_id(position)
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

func rotate(position: Vector2, angle: int) -> void:
	var tile_id := get_id(position)
	if tiles.has(tile_id):
		var tile : Tile = tiles[tile_id]
		tile.rotate(angle)
		
		# rotate all the objects contained within the tile as well
		WorldObjects.rotate_tile_contents(position, angle)

func reverse(position: Vector2) -> void:
	var tile_id := get_id(position)
	if tiles.has(tile_id):
		var tile : Tile = tiles[tile_id]
		tile.reverse()

func get_id(position: Vector2) -> String:
	return str(floor(position.x / 8)) + "," + str(floor(position.y / 8))

func get_at(position: Vector2) -> Tile:
	var id := get_id(position)
	if tiles.has(id):
		return tiles[id]
	else:
		return null

func can_add(position: Vector2) -> bool:
	return not tiles.has(get_id(position))

func destroy(tile: Tile) -> void:
	var id := get_id(tile.global_position)
	if not tiles.erase(id):
		push_error("Tried to delete a tile not in WorldTiles")
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
	
