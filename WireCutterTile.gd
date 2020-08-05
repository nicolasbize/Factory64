extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

const SilverWire = preload("res://Objects/Wires/SilverWire.tscn")
const IronWire = preload("res://Objects/Wires/IronWire.tscn")
const SiliconWire = preload("res://Objects/Wires/SiliconWire.tscn")
const GoldWire = preload("res://Objects/Wires/GoldWire.tscn")

func create_item_from_ore(ore_type):
	var wire = null
	match ore_type:
		Constants.ObjectType.SILVER_ORE:
			wire = SilverWire.instance()
			wire.set_type(Constants.ObjectType.SILVER_WIRE)
		Constants.ObjectType.SILICON_ORE:
			wire = SiliconWire.instance()
			wire.set_type(Constants.ObjectType.SILICON_WIRE)
		Constants.ObjectType.GOLD_ORE:
			wire = GoldWire.instance()
			wire.set_type(Constants.ObjectType.GOLD_WIRE)
		Constants.ObjectType.IRON_ORE:
			wire = IronWire.instance()
			wire.set_type(Constants.ObjectType.IRON_WIRE)
	return wire
