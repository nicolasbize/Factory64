extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

const SilverPlate = preload("res://Objects/Plates/SilverPlate.tscn")
const IronPlate = preload("res://Objects/Plates/IronPlate.tscn")
const SiliconPlate = preload("res://Objects/Plates/SiliconPlate.tscn")
const GoldPlate = preload("res://Objects/Plates/GoldPlate.tscn")

func create_item_from_ore(ore_type):
	var plate = null
	match ore_type:
		Constants.ObjectType.SILVER_ORE:
			plate = SilverPlate.instance()
			plate.set_type(Constants.ObjectType.SILVER_PLATE)
		Constants.ObjectType.SILICON_ORE:
			plate = SiliconPlate.instance()
			plate.set_type(Constants.ObjectType.SILICON_PLATE)
		Constants.ObjectType.GOLD_ORE:
			plate = GoldPlate.instance()
			plate.set_type(Constants.ObjectType.GOLD_PLATE)
		Constants.ObjectType.IRON_ORE:
			plate = IronPlate.instance()
			plate.set_type(Constants.ObjectType.IRON_PLATE)
	return plate

