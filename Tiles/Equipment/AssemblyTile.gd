## A tile that gets 3 inputs and assembles a product in return
class_name AssemblyTile
extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

# default to first recipe (resistor)
var active_recipe: int = Constants.AssemblyOutputs[0]

func _ready() -> void:
	._ready()
	destroy_invalid_inputs = false

func get_list_valid_outputs() -> Array:
	return [active_recipe]

func get_tile_speed() -> float:
	return BASE_SPEED - GameState.upgrades[Constants.UpgradeType.ASSEMBLERS] * 0.1
