extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var tile_timer = $TileTimer
onready var sprite = $Sprite

# flow direction
#TODO : change this by Vector2.RIGHT, etc.
enum Facing {RIGHT, DOWN, LEFT, UP}
var direction = Facing.RIGHT

export (float) var speed = 1

func _ready():
	tile_timer.start(speed)

func rotate(angle):
	rotation = fmod(rotation + deg2rad(angle), 2 * PI)
	if angle > 0:
		direction = (direction + 1) % Facing.size()
	else:
		direction = (direction + Facing.size() - 1) % Facing.size()

func is_valid_obj_pos(pos):
	print("can't accept object, need to be defined")
	return false

# virtual
func reverse():
	pass
	
func _on_TileTimer_timeout():
	pass
