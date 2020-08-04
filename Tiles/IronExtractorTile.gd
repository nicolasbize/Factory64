extends "res://Tiles/ExtractorTile.gd"

const IronOre = preload("res://Objects/IronOre.tscn")

func create_ore(pos):
	var ore = IronOre.instance()
	ore.set_type(Constants.ObjectType.IRON_ORE)
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
