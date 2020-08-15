## Extracts silver from the ground
class_name SilverExtractorTile
extends "res://Tiles/Extractors/ExtractorTile.gd"

const SilverOre := preload("res://Objects/Ore/SilverOre.tscn")

func create_ore(pos: Vector2) -> void:
	var ore : MovableObject = SilverOre.instance()
	ore.set_type(Constants.ObjectType.SILVER_ORE)
	container.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
