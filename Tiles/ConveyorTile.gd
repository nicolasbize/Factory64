extends "res://Tiles/Tile.gd"


func _process(delta):
	animationPlayer.play("Enabled-R")

func is_conveyor():
	return true

func reverse():
	rotation += deg2rad(180)

func on_world_tile_update(tile, id, position):
	if tile == self:
		pass
