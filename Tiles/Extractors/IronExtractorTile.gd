## Extracts iron from the ground
class_name IronExtractorTile
extends "res://Tiles/Extractors/ExtractorTile.gd"

const IronOre := preload("res://Objects/Ore/IronOre.tscn")

func create_ore(pos: Vector2) -> void:
	var ore : MovableObject = IronOre.instance()
	ore.set_type(Constants.ObjectType.IRON_ORE)
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
