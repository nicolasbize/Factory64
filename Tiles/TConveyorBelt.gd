extends "res://Tiles/Tile.gd"

enum { RIGHT, TOP, DOWN }
var direction = RIGHT

func _process(delta):
	if direction == RIGHT:
		animationPlayer.play("Enabled-R")
	elif direction == TOP:
		animationPlayer.play("Enabled-T")
	else:
		animationPlayer.play("Enabled-D")

func is_conveyor():
	return true

func reverse():
	direction += 1
	if direction > 2:
		direction = 0
