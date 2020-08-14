## Generic Game Tile placed by the player
class_name Tile
extends Node2D

const TILE_SPEED = 0.1

onready var animationPlayer := $AnimationPlayer
onready var audio_timer := $AudioTimer
onready var destroy_sound := $DestroyTileSound
onready var operating_sound := $OperatingSound
onready var place_sound := $PlaceTileSound
onready var sprite := $Sprite
onready var tile_timer := $TileTimer

enum Facing {RIGHT, DOWN, LEFT, UP}

var direction : int = Facing.RIGHT
var power : int = Constants.Power.LOWEST
var type : int = Constants.TileType.NONE
var is_operational : bool = false

func _ready() -> void:
	tile_timer.start(TILE_SPEED)
	audio_timer.start()
	place_sound.play()

func rotate(angle: float) -> void:
	rotation = fmod(rotation + deg2rad(angle), 2 * PI)
	if angle > 0:
		direction = (direction + 1) % Facing.size()
	else:
		direction = (direction + Facing.size() - 1) % Facing.size()

# Virtual
func is_valid_obj_pos(_pos) -> bool:
	push_error("providing valid placement must be defined by inheritance: " + str(type))
	return false

# virtual
func reverse() -> void:
	push_error("reverse must be defined by inheritance")
	pass


func _on_TileTimer_timeout() -> void:
	tile_tick()

func tile_tick() -> void:
	push_error("tile_tick needs to be defined by parent")
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

func set_power(pwr: int) -> void:
	power = pwr

func is_upgradable() -> bool:
	return [
		Constants.TileType.GOLD,
		Constants.TileType.SILVER,
		Constants.TileType.SILICON,
		Constants.TileType.IRON,
		Constants.TileType.CUTTER,
		Constants.TileType.FURNACE,
	].find(type) > -1

func _on_AudioTimer_timeout() -> void:
	if is_operational:
		operating_sound.play()
	else:
		operating_sound.stop()

func _on_Tile_tree_exiting():
	destroy_sound.play()
