## Extracts silicon from the ground
class_name SiliconExtractorTile
extends "res://Tiles/Extractors/ExtractorTile.gd"

const SiliconOre := preload("res://Objects/Ore/SiliconOre.tscn")

func create_ore(pos: Vector2) -> void:
	var ore : MovableObject = SiliconOre.instance()
	ore.set_type(Constants.ObjectType.SILICON_ORE)
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(ore)
	ore.global_position = pos
	WorldObjects.add(ore, pos)
