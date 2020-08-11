## A T-shape conveyor belt tile
class_name TBeltTile
extends "res://Tiles/Belts/BaseConveyorTile.gd"

onready var flow := $Flow
onready var flow2 := $Flow2
onready var flow3 := $Flow3

enum FlowDir {Right, Top, Bottom}

var flow_dir : int = FlowDir.Right

func _ready() -> void:
	flow_areas.append(flow)
	flow_areas.append(flow2)
	flow_areas.append(flow3)
	power = Constants.Power.HIGHEST
	
func _process(_delta: float) -> void:
	if is_anim_playing:
		match flow_dir:
			FlowDir.Right:
				animationPlayer.play("FlowRight")
			FlowDir.Top:
				animationPlayer.play("FlowTop")
			FlowDir.Bottom:
				animationPlayer.play("FlowDown")

# When being reversed, this can go 3 ways
func reverse() -> void:
	flow_dir += 1
	if flow_dir > FlowDir.size() - 1:
		flow_dir = 0
	match flow_dir:
		FlowDir.Right:
			flow.is_reverse = false
			flow2.is_reverse = false
			flow3.is_reverse = false
		FlowDir.Top:
			flow.is_reverse = true
			flow2.is_reverse = true
			flow3.is_reverse = false
		FlowDir.Bottom:
			flow.is_reverse = true
			flow2.is_reverse = false
			flow3.is_reverse = true
