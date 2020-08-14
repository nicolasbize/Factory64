## Dialog to view and edit a tile's behavior
class_name TileViewDialog
extends Control

onready var lvl_1_button := $"InfoPanel/PowerMeter/Lvl-1Button"
onready var lvl_2_button := $"InfoPanel/PowerMeter/Lvl-2Button"
onready var lvl_2_tooltip := $"InfoPanel/PowerMeter/Lvl-2Button/TooltipTrigger"
onready var lvl_3_button := $"InfoPanel/PowerMeter/Lvl-3Button"
onready var lvl_3_tooltip := $"InfoPanel/PowerMeter/Lvl-3Button/TooltipTrigger"
onready var lvl_4_button := $"InfoPanel/PowerMeter/Lvl-4Button"
onready var lvl_4_tooltip := $"InfoPanel/PowerMeter/Lvl-4Button/TooltipTrigger"
onready var lvl_5_button := $"InfoPanel/PowerMeter/Lvl-5Button"
onready var lvl_5_tooltip := $"InfoPanel/PowerMeter/Lvl-5Button/TooltipTrigger"
onready var power_meter := $InfoPanel/PowerMeter
onready var recipe_selector := $InfoPanel/RecipeSelector
onready var tick := $InfoPanel/PowerMeter/Tick

var active_tile: Tile = null

func _on_LvlButton_click(button: ClickableButton) -> void:
	tick.rect_global_position = button.rect_global_position + Vector2(1, -1)
	match button:
		lvl_1_button:
			active_tile.set_power(Constants.Power.LOWEST)
		lvl_2_button:
			active_tile.set_power(Constants.Power.LOW)
		lvl_3_button:
			active_tile.set_power(Constants.Power.MEDIUM)
		lvl_4_button:
			active_tile.set_power(Constants.Power.HIGH)
		lvl_5_button:
			active_tile.set_power(Constants.Power.HIGHEST)

func set_tile(tile: Tile) -> void:
	if tile != null:
		tile.disconnect("storage_change", self, "_on_storage_change")
	active_tile = tile
	recipe_selector.visible = false
	power_meter.visible = false	
	if tile.is_upgradable():
		tick.rect_position = Vector2(37, 6) + Vector2.RIGHT * 5 * tile.power
		var upgraded := 0
		power_meter.visible = true
		recipe_selector.visible = false
		match tile.type:
			Constants.TileType.CUTTER, Constants.TileType.FURNACE:
				upgraded = GameState.upgrades[Constants.UpgradeType.PROCESSORS]
			Constants.TileType.GOLD, Constants.TileType.IRON, Constants.TileType.SILICON, Constants.TileType.SILVER:
				upgraded = GameState.upgrades[Constants.UpgradeType.EXTRACTORS]
		var buttons = [lvl_2_button, lvl_3_button, lvl_4_button, lvl_5_button]
		var tooltips = [lvl_2_tooltip, lvl_3_tooltip, lvl_4_tooltip, lvl_5_tooltip]
		var tip_texts = ["Low speed", "Normal speed", "Fast speed", "Fastest speed"]
		for i in buttons.size():
			if i < upgraded:
				buttons[i].enable()
				tooltips[i].tooltip_text = tip_texts[i]
			else:
				buttons[i].disable()
				tooltips[i].tooltip_text = tip_texts[i] + "\nUpgrade to unlock"
	elif tile.type == Constants.TileType.FACTORY or tile.type == Constants.TileType.ASSEMBLY:
		recipe_selector.visible = true
		power_meter.visible = false
		if tile.type == Constants.TileType.FACTORY:
			recipe_selector.init(Constants.FactoryOutputs)
		elif tile.type == Constants.TileType.ASSEMBLY:
			recipe_selector.init(Constants.AssemblyOutputs)
		recipe_selector.set_recipe(tile.active_recipe)
		recipe_selector.refresh_ui(tile.contents)
		tile.connect("storage_change", self, "_on_storage_change")
		
func _on_storage_change(tile: Tile, contents: Array) -> void:
	if tile == active_tile:
		recipe_selector.refresh_ui(contents)

func _on_ClearButton_click(_el: ClickableButton) -> void:
	active_tile.clear()

func _on_DestroyButton_click(_el: ClickableButton) -> void:
	active_tile.clear()
	active_tile.destroy()

func _on_RecipeSelector_change_recipe(type: int) -> void:
	active_tile.active_recipe = type
