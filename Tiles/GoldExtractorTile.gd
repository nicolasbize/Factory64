extends "res://Tiles/ExtractorTile.gd"

const GoldOre = preload("res://Objects/GoldOre.tscn")

func create_ore(pos):
	var ore = GoldOre.instance()
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
