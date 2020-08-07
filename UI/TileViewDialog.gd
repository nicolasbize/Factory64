extends Control

onready var tick = $InfoPanel/Tick

var active_tile = null
onready var lvl_1_button = $"InfoPanel/Lvl-1Button"
onready var lvl_2_button = $"InfoPanel/Lvl-2Button"
onready var lvl_3_button = $"InfoPanel/Lvl-3Button"
onready var lvl_4_button = $"InfoPanel/Lvl-4Button"
onready var lvl_5_button = $"InfoPanel/Lvl-5Button"

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
	tick.rect_position = Vector2(37, 6) + Vector2.RIGHT * 5 * tile.power
	print("updating tile ui with power " + str(tile.power))
	var upgraded = 0
	match tile.type:
		Constants.TileType.BELT, Constants.TileType.LBELT, Constants.TileType.TBELT:
			upgraded = GameState.belt_power_upgrade
		Constants.TileType.ASSEMBLY:
			upgraded = GameState.assemblies_power_upgrade
		Constants.TileType.CUTTER:
			upgraded = GameState.cutter_power_upgrade
		Constants.TileType.FACTORY:
			upgraded = GameState.factories_power_upgrade
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

func _on_ClearButton_click(el):
	active_tile.clear()

func _on_DestroyButton_click(el):
	active_tile.destroy()
