extends "res://Tiles/Extractors/ExtractorTile.gd"

const GoldOre = preload("res://Objects/Ore/GoldOre.tscn")

func create_ore(pos):
	var ore = GoldOre.instance()
	ore.set_type(Constants.ObjectType.GOLD_ORE)
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
