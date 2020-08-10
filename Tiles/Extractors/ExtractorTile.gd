## Virtual. Extracts ore from the ground
## The cost grows bigger fibonacci-style as the player has more of those
class_name ExtractorTile
extends "res://Tiles/Tile.gd"

func _process(_delta: float) -> void:
	animationPlayer.play("Enabled")

func _on_TileTimer_timeout() -> void:
	tile_timer.start(get_tile_speed())
	var target_tile: Tile = null
	if direction == Facing.RIGHT:
		target_tile = WorldTiles.get_at(global_position + Vector2(8, 0))
		if target_tile != null:
			var spots := []
			for y in range(-2, 2):
				spots.append(global_position + Vector2(4, y))
			spots.shuffle()
			attempt_send_ore(target_tile, spots[0])
	elif direction == Facing.LEFT:
		target_tile = WorldTiles.get_at(global_position + Vector2(-8, 0))
		if target_tile != null:
			var spots := []
			for y in range(-2, 2):
				spots.append(global_position + Vector2(-4, y))
			spots.shuffle()
			attempt_send_ore(target_tile, spots[0])
	elif direction == Facing.UP:
		target_tile = WorldTiles.get_at(global_position + Vector2(0, -8))
		if target_tile != null:
			var spots := []
			for x in range(-2, 2):
				spots.append(global_position + Vector2(x, -5))
			spots.shuffle()
			attempt_send_ore(target_tile, spots[0])
	elif direction == Facing.DOWN:
		target_tile = WorldTiles.get_at(global_position + Vector2(0, 8))
		if target_tile != null:
			var spots := []
			for x in range(-2, 2):
				spots.append(global_position + Vector2(x, 4))
			spots.shuffle()
			attempt_send_ore(target_tile, spots[0])
				
func attempt_send_ore(tile: Tile, pos: Vector2) -> void:
	if tile.is_valid_obj_pos(pos) and not WorldObjects.has_at(pos):
		create_ore(pos)
#		var ore := create_ore(pos)
#		var main = get_tree().current_scene.find_node("MovingObjects", false, false)
#		main.add_item(ore)
#		ore.global_position = pos
#		WorldObjects.add(ore, pos)


## VIRTUAL
func create_ore(_pos: Vector2) -> void:
	# get parent to implement this
	push_error("type of ore to create not defined by inheritance")
