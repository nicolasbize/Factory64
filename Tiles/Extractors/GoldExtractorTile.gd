## Extracts gold from the ground
class_name GoldExtractorTile
extends "res://Tiles/Extractors/ExtractorTile.gd"

const GoldOre := preload("res://Objects/Ore/GoldOre.tscn")

func create_ore(pos: Vector2) -> void:
	var ore : MovableObject = GoldOre.instance()
	ore.set_type(Constants.ObjectType.GOLD_ORE)
	var main = get_node("/root/LittleBigFactory/World/MovingObjects")
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
