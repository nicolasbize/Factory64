## Dialog to view and edit a tile's behavior
class_name TileViewDialog
extends Control

onready var lvl_1_button := $"InfoPanel/PowerMeter/Lvl-1Button"
onready var lvl_2_button := $"InfoPanel/PowerMeter/Lvl-2Button"
onready var lvl_3_button := $"InfoPanel/PowerMeter/Lvl-3Button"
onready var lvl_4_button := $"InfoPanel/PowerMeter/Lvl-4Button"
onready var lvl_5_button := $"InfoPanel/PowerMeter/Lvl-5Button"
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
		for i in buttons.size():
			if i < upgraded:
				buttons[i].enable()
			else:
				buttons[i].disable()
	elif tile.type == Constants.TileType.FACTORY or tile.type == Constants.TileType.ASSEMBLY:
		recipe_selector.visible = true
		power_meter.visible = false
		if tile.type == Constants.TileType.FACTORY:
			recipe_selector.init(Constants.FactoryOutputs)
		elif tile.type == Constants.TileType.ASSEMBLY:
			recipe_selector.init(Constants.AssemblyOutputs)
		recipe_selector.set_recipe(tile.active_recipe)
		recipe_selector.refresh_ui(tile.contents)
		if tile.connect("storage_change", self, "_on_storage_change") != OK:
			push_error("TileViewDialog could not connect to the tile storage")
		
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
