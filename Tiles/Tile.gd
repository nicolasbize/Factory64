extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var tile_timer = $TileTimer
onready var sprite = $Sprite

# flow direction
#TODO : change this by Vector2.RIGHT, etc.
enum Facing {RIGHT, DOWN, LEFT, UP}
var direction = Facing.RIGHT

export (float) var speed = 1
export (Constants.TileType) var type
export (Constants.Power) var power

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

# destroy tile contents
func clear():
	for x in range(global_position.x - 4, global_position.x + 4):
		for y in range(global_position.y - 4, global_position.y + 4):
			var obj = WorldObjects.get_at(Vector2(x, y))
			if obj != null:
				obj.queue_free()
				WorldObjects.destroy(obj)

func destroy():
	var tile = WorldTiles.get_at(global_position)
	WorldTiles.destroy(tile)
	queue_free()

func set_power(pwr):
	power = pwr
	match power:
		Constants.Power.LOWEST:
			speed = 1
		Constants.Power.LOW:
			speed = 0.8
		Constants.Power.MEDIUM:
			speed = 0.6
		Constants.Power.HIGH:
			speed = 0.4
		Constants.Power.HIGHEST:
			speed = 0.2

func is_upgradable():
	return type != Constants.TileType.FACTORY and type != Constants.TileType.ASSEMBLY
