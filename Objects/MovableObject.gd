## An item that can be moved around in the game
class_name MovableObject
extends Area2D

onready var sprite := $Sprite

var size : int = Constants.ObjectSize.SMALL
var type : int = Constants.ObjectType.NONE

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	var v := rng.randf_range(0.8, 1)
	sprite.modulate = Color(v, v, v)

func set_type(object_type: int) -> void:
	type = object_type
