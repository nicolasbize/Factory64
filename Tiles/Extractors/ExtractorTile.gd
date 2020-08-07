extends "res://Tiles/Tile.gd"

enum {RIGHT, TOP, LEFT, BOTTOM}
var possible_directions = []
var round_robin = 0
var current_dir = null

export (int) var efficiency = 1 # 1-4, might replace with enum

func _process(delta):
	animationPlayer.play("Enabled")

func _on_TileTimer_timeout():
	tile_timer.start(speed)
	var target_tile = null
	if direction == Facing.RIGHT:
		target_tile = WorldTiles.get_at(global_position + Vector2(8, 0))
		if target_tile != null:
			var spots = []
			for y in range(-2, 2):
				spots.append(global_position + Vector2(4, y))
			spots.shuffle()
			attempt_send_ore(target_tile, spots[0])
				
	elif direction == Facing.LEFT:
		target_tile = WorldTiles.get_at(global_position + Vector2(-8, 0))
		if target_tile != null:
			var spots = []
			for y in range(-2, 2):
				spots.append(global_position + Vector2(-4, y))
			spots.shuffle()
			attempt_send_ore(target_tile, spots[0])
	elif direction == Facing.UP:
		target_tile = WorldTiles.get_at(global_position + Vector2(0, -8))
		if target_tile != null:
			var spots = []
			for x in range(-2, 2):
				spots.append(global_position + Vector2(x, -5))
			spots.shuffle()
			attempt_send_ore(target_tile, spots[0])
	elif direction == Facing.DOWN:
		target_tile = WorldTiles.get_at(global_position + Vector2(0, 8))
		if target_tile != null:
			var spots = []
			for x in range(-2, 2):
				spots.append(global_position + Vector2(x, 4))
			spots.shuffle()
			attempt_send_ore(target_tile, spots[0])
				

func attempt_send_ore(tile, pos):
	if tile.is_valid_obj_pos(pos) and not WorldObjects.has_at(pos):
		create_ore(pos)
		
func create_ore(pos):
	# get parent to implement this
	pass
