## Shapes Ore into Wires
class_name WireCutterTile
extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func get_list_valid_outputs() -> Array:
	return Constants.WireCutterOuputs

func get_processing_speed() -> float:
	return 2.5 - power * 0.5
