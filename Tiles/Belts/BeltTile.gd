## A straight conveyor belt game tile
class_name BeltTile
extends "res://Tiles/Belts/BaseConveyorTile.gd"

onready var flow := $Flow

func _ready() -> void:
	flow_areas.append(flow)
	
func _process(_delta: float) -> void:
	if is_anim_playing:
		animationPlayer.play("FlowRight")
	sprite.scale.x = -1 if is_reverse else 1
