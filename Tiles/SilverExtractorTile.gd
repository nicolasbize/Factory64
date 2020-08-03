extends "res://Tiles/ExtractorTile.gd"

const SilverOre = preload("res://Objects/SilverOre.tscn")

func create_ore(pos):
	var ore = SilverOre.instance()
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
