extends Control

onready var tick = $InfoPanel/PowerMeter/Tick

var active_tile = null
onready var lvl_1_button = $"InfoPanel/PowerMeter/Lvl-1Button"
onready var lvl_2_button = $"InfoPanel/PowerMeter/Lvl-2Button"
onready var lvl_3_button = $"InfoPanel/PowerMeter/Lvl-3Button"
onready var lvl_4_button = $"InfoPanel/PowerMeter/Lvl-4Button"
onready var lvl_5_button = $"InfoPanel/PowerMeter/Lvl-5Button"
onready var power_meter = $InfoPanel/PowerMeter
onready var recipe_selector = $InfoPanel/RecipeSelector

func _on_LvlButton_click(button):
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

func set_tile(tile):
	active_tile = tile
	if tile.is_upgradable():
		tick.rect_position = Vector2(37, 6) + Vector2.RIGHT * 5 * tile.power
		var upgraded = 0
		power_meter.visible = true
		recipe_selector.visible = false
		match tile.type:
			Constants.TileType.BELT, Constants.TileType.LBELT, Constants.TileType.TBELT:
				upgraded = GameState.belt_power_upgrade
			Constants.TileType.CUTTER:
				upgraded = GameState.cutter_power_upgrade
			Constants.TileType.FURNACE:
				upgraded = GameState.burner_power_upgrade
			Constants.TileType.GOLD, Constants.TileType.IRON, Constants.TileType.SILICON, Constants.TileType.SILVER:
				upgraded = GameState.extractor_power_upgrade
		var buttons = [lvl_2_button, lvl_3_button, lvl_4_button, lvl_5_button]
		for i in buttons.size():
			if i < upgraded:
				buttons[i].enable()
			else:
				buttons[i].disable()
	else:
		recipe_selector.visible = true
		power_meter.visible = false
		if tile.type == Constants.TileType.FACTORY:
			recipe_selector.init(Constants.FactoryOutputs)
		elif tile.type == Constants.TileType.ASSEMBLY:
			recipe_selector.init(Constants.AssemblyOutputs)

func _on_ClearButton_click(el):
	active_tile.clear()

func _on_DestroyButton_click(el):
	active_tile.clear()
	active_tile.destroy()
