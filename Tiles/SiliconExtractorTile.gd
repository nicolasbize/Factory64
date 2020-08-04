extends "res://Tiles/ExtractorTile.gd"

const SiliconOre = preload("res://Objects/SiliconOre.tscn")

func create_ore(pos):
	var ore = SiliconOre.instance()
	ore.set_type(Constants.ObjectType.SILICON_ORE)
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
