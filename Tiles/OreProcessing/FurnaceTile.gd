extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func get_list_valid_outputs():
	return [
		Constants.ObjectType.SILVER_PLATE, \
		Constants.ObjectType.SILICON_PLATE, \
		Constants.ObjectType.GOLD_PLATE, \
		Constants.ObjectType.IRON_PLATE]
