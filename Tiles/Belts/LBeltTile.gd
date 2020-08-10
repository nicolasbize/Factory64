## An L-shape conveyor belt tile
class_name LBeltTile
extends "res://Tiles/Belts/BaseConveyorTile.gd"

onready var flow := $Flow
onready var flow2 := $Flow2

func _ready() -> void:
	flow_areas.append(flow)
	flow_areas.append(flow2)
	
func _process(_delta: float) -> void:
	if is_anim_playing:
		animationPlayer.play("FlowTop" if is_reverse else "FlowRight")
