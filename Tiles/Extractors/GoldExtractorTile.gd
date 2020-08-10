## Extracts gold from the ground
class_name GoldExtractorTile
extends "res://Tiles/Extractors/ExtractorTile.gd"

const GoldOre := preload("res://Objects/Ore/GoldOre.tscn")

func create_ore(pos: Vector2) -> void:
	var ore : MovableObject = GoldOre.instance()
	ore.set_type(Constants.ObjectType.GOLD_ORE)
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
