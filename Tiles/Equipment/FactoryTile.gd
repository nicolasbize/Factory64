## A tile that gets 2 inputs and assembles a component in return
class_name FactoryTile
extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

var active_recipe: int = Constants.FactoryOutputs[0]

func _ready() -> void:
	._ready()
	destroy_invalid_inputs = false

# contrary to a furnace/wirecutter, we can only have a single output here
func get_list_valid_outputs() -> Array:
	return [active_recipe]

func get_processing_speed() -> float:
	return 1.7 - GameState.upgrades[Constants.UpgradeType.ASSEMBLERS] * 0.4
