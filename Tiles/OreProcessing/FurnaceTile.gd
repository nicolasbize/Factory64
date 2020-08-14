## Melts Ore into Plates
class_name FurnaceTile
extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func get_list_valid_outputs() -> Array:
	return Constants.FurnaceOutputs

func get_processing_speed() -> float:
	return 2.2 - power * 0.5
