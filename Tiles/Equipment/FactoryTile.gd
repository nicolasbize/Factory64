extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func get_list_valid_outputs():
	return [
		Constants.ObjectType.BATTERY, \
		Constants.ObjectType.CAPACITOR, \
		Constants.ObjectType.CHIP, \
		Constants.ObjectType.CIRCUIT, \
		Constants.ObjectType.DIODE, \
		Constants.ObjectType.INDUCTOR, \
		Constants.ObjectType.RELAY, \
		Constants.ObjectType.RESISTOR, \
		Constants.ObjectType.TRANSISTOR]
