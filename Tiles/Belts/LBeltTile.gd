extends "res://Tiles/Belts/BaseConveyorTile.gd"

onready var flow = $Flow
onready var flow2 = $Flow2

func _ready():
	flow_areas.append(flow)
	flow_areas.append(flow2)
	
func _process(delta):
	if is_anim_playing:
		animationPlayer.play("FlowTop" if is_reverse else "FlowRight")
