## Shapes Ore into Wires
class_name WireCutterTile
extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func get_list_valid_outputs() -> Array:
	return Constants.WireCutterOuputs
