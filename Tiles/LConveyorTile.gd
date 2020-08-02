extends "res://Tiles/Tile.gd"

enum { FORWARD, BACKWARD }
var direction = FORWARD

onready var belt_timer = $BeltTimer
onready var area_down = $AreaDown
onready var area_right = $AreaRight
onready var valid_points = $ValidPoints

export (float) var speed = 1

func _ready():
	belt_timer.start(speed)

func _physics_process(delta):
	animationPlayer.play("Enabled-R" if direction == FORWARD else "Enabled-T")

func is_conveyor():
	return true

func reverse():
	direction += 1
	if direction > 1:
		direction = 0

func _on_BeltTimer_timeout():
	move_objects()
	belt_timer.start(speed)

func move_objects():
	for obj in area_right.get_overlapping_areas():
		if obj != area_right:
			var movement = Vector2.ZERO
			if direction == FORWARD:
				movement.x += 1
			else:
				movement.x -= 1
			movement = movement.rotated(rotation)
			var new_loc = obj.global_position + movement
			WorldObjects.move(obj, new_loc)
	for obj in area_down.get_overlapping_areas():
		if obj != area_down:
			var movement = Vector2.ZERO
			if direction == FORWARD:
				movement.y += 1
			else:
				movement.y -= 1
			movement = movement.rotated(rotation)
			var new_loc = obj.global_position + movement
			WorldObjects.move(obj, new_loc)
		
func can_accept(obj, new_pos):
	for point in valid_points.get_children():
		if point.global_position == new_pos:
			return true
	print("tile doesn't contain this valid point")
	return false
