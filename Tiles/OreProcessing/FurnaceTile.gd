## Melts Ore into Plates
class_name FurnaceTile
extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func get_list_valid_outputs() -> Array:
	return Constants.FurnaceOutputs

func get_tile_speed() -> float:
	return 2.5 - power * 0.5
