extends "res://Tiles/Extractors/ExtractorTile.gd"

const SilverOre = preload("res://Objects/Ore/SilverOre.tscn")

func create_ore(pos):
	var ore = SilverOre.instance()
	ore.set_type(Constants.ObjectType.SILVER_ORE)
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
