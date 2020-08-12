## Generic Game Tile placed by the player
class_name Tile
extends Node2D

const BASE_SPEED = 0.5

onready var animationPlayer := $AnimationPlayer
onready var sprite := $Sprite
onready var tile_timer := $TileTimer

enum Facing {RIGHT, DOWN, LEFT, UP}

var direction : int = Facing.RIGHT
var power : int = Constants.Power.LOWEST
var type : int = Constants.TileType.NONE

func _ready() -> void:
	tile_timer.start(get_tile_speed())

func rotate(angle: float) -> void:
	rotation = fmod(rotation + deg2rad(angle), 2 * PI)
	if angle > 0:
		direction = (direction + 1) % Facing.size()
	else:
		direction = (direction + Facing.size() - 1) % Facing.size()

# Virtual
func is_valid_obj_pos(_pos) -> bool:
	push_error("providing valid placement must be defined by inheritance")
	return false

# virtual
func reverse() -> void:
	push_error("reverse must be defined by inheritance")
	pass

# Virtual
func _on_TileTimer_timeout() -> void:
	push_error("tile timeout must defined by inheritance")
	pass

func clear() -> void:
	for x in range(global_position.x - 4, global_position.x + 4):
		for y in range(global_position.y - 4, global_position.y + 4):
			var obj : MovableObject = WorldObjects.get_at(Vector2(x, y))
			if obj != null:
				obj.queue_free()
				WorldObjects.destroy(obj)

func destroy() -> void:
	var tile : Tile = WorldTiles.get_at(global_position)
	WorldTiles.destroy(tile)
	queue_free()

func get_tile_speed() -> float:
	return BASE_SPEED - power * 0.1

func set_power(pwr: int) -> void:
	power = pwr

func is_upgradable() -> bool:
	return [
		Constants.TileType.GOLD,
		Constants.TileType.SILVER,
		Constants.TileType.SILICON,
		Constants.TileType.IRON,
		Constants.TileType.ASSEMBLY,
		Constants.TileType.CUTTER,
		Constants.TileType.FACTORY,
		Constants.TileType.FURNACE,
	].find(type) > -1
