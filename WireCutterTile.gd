extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func get_list_valid_outputs():
	return [
		Constants.ObjectType.SILVER_WIRE, \
		Constants.ObjectType.SILICON_WIRE, \
		Constants.ObjectType.GOLD_WIRE, \
		Constants.ObjectType.IRON_WIRE]
