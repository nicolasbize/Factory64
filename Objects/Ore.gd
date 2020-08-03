extends Area2D

var rng = RandomNumberGenerator.new()

onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var v = rng.randf_range(0.8, 1)
	sprite.modulate = Color(v, v, v)
