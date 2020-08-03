extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var tile_timer = $TileTimer
onready var sprite = $Sprite

export (float) var speed = 1

func _ready():
	tile_timer.start(speed)

func reverse():
	print("not defined by parent")
	pass

func rotate(angle):
	rotation = fmod(rotation + deg2rad(angle), 2 * PI)

func is_valid_obj_pos(pos):
	print("can't accept object, need to be defined")
	return false

func _on_TileTimer_timeout():
	pass # Replace with function body.
