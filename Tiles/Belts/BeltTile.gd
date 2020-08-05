extends "res://Tiles/Belts/BaseConveyorTile.gd"

onready var flow = $Flow

func _ready():
	flow_areas.append(flow)
	
func _process(delta):
	if is_anim_playing:
		animationPlayer.play("FlowRight")

	sprite.scale.x = -1 if is_reverse else 1
