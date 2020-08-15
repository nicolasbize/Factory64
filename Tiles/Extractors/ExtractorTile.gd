## Virtual. Extracts ore from the ground
## The cost grows bigger fibonacci-style as the player has more of those
class_name ExtractorTile
extends "res://Tiles/Tile.gd"

var extract_counter := 0
var container : Node = null

func _ready() -> void:
	container = get_node("/root/LittleBigFactory/World/MovingObjects")

func _process(_delta: float) -> void:
	animationPlayer.play("Enabled")

func tile_tick() -> void:
	extract_counter += 1
	if extract_counter > 4 - power:
		extract_counter = 0
		extract_ore()

func extract_ore() -> void:
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
		is_operational = true
		create_ore(pos)
	else:
		is_operational = false


## VIRTUAL
func create_ore(_pos: Vector2) -> void:
	# get parent to implement this
	push_error("type of ore to create not defined by inheritance")
