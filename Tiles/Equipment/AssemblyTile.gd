extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func get_list_valid_outputs():
	return [
		Constants.ObjectType.FAN, \
		Constants.ObjectType.SPEAKER, \
		Constants.ObjectType.PSU, \
		Constants.ObjectType.MEMORY, \
		Constants.ObjectType.CPU, \
		Constants.ObjectType.GPU, \
		Constants.ObjectType.MONITOR, \
		Constants.ObjectType.RADIO, \
		Constants.ObjectType.MOTHERBOARD, \
		Constants.ObjectType.PHONE, \
		Constants.ObjectType.COMPUTER ]
