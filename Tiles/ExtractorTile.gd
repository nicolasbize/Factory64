extends "res://Tiles/Tile.gd"

enum {RIGHT, TOP, LEFT, BOTTOM}
var possible_directions = []
var round_robin = 0
var current_dir = null

export (int) var efficiency = 1 # 1-4, might replace with enum

func _process(delta):
	animationPlayer.play("Enabled")

func _on_TileTimer_timeout():
	refresh_possible_directions()
	var target_tile = null
	if current_dir == RIGHT:
		target_tile = WorldTiles.get_at(global_position + Vector2(8, 0))
		if target_tile != null:
			var spots = []
			for y in range(-2, 2):
				spots.append(global_position + Vector2(4, y))
			spots.shuffle()
			spots = spots.slice(0, efficiency - 1)
			for pos in spots:
				attempt_send_ore(target_tile, pos)
	elif current_dir == LEFT:
		target_tile = WorldTiles.get_at(global_position + Vector2(-8, 0))
		if target_tile != null:
			var spots = []
			for y in range(-2, 2):
				spots.append(global_position + Vector2(-4, y))
			spots.shuffle()
			spots = spots.slice(0, efficiency - 1)
			for pos in spots:
				attempt_send_ore(target_tile, pos)
	elif current_dir == TOP:
		target_tile = WorldTiles.get_at(global_position + Vector2(0, -8))
		if target_tile != null:
			var spots = []
			for x in range(-2, 2):
				spots.append(global_position + Vector2(x, -5))
			spots.shuffle()
			spots = spots.slice(0, efficiency - 1)
			for pos in spots:
				attempt_send_ore(target_tile, pos)
	elif current_dir == BOTTOM:
		target_tile = WorldTiles.get_at(global_position + Vector2(0, 8))
		
		if target_tile != null:
			var spots = []
			for x in range(-2, 2):
				spots.append(global_position + Vector2(x, 4))
			spots.shuffle()
			spots = spots.slice(0, efficiency - 1)
			for pos in spots:
				attempt_send_ore(target_tile, pos)
				
func refresh_possible_directions():
	possible_directions = []
	if WorldTiles.get_at(global_position + Vector2(8, 0)) != null:
		possible_directions.append(RIGHT)
	if WorldTiles.get_at(global_position + Vector2(0, 8)) != null:
		possible_directions.append(BOTTOM)		
	if WorldTiles.get_at(global_position + Vector2(-8, 0)) != null:
		possible_directions.append(LEFT)
	if WorldTiles.get_at(global_position + Vector2(0, -8)) != null:
		possible_directions.append(TOP)
	if possible_directions.size() == 0:
		current_dir = null
	else:
		round_robin += 1
		if round_robin > possible_directions.size() - 1:
			round_robin = 0
		current_dir = possible_directions[round_robin]

	
func attempt_send_ore(tile, pos):
	if tile.is_valid_obj_pos(pos) and not WorldObjects.has_at(pos):
		create_ore(pos)
		
func create_ore(pos):
	# get parent to implement this
	pass
