extends Control

onready var tick = $InfoPanel/Tick

var active_tile = null

func _on_LvlButton_click(lvl_sprite):
	tick.rect_global_position = lvl_sprite.rect_global_position + Vector2(1, -1)

func set_tile(tile):
	active_tile = tile
	tick.rect_position = Vector2(36, 18) + Vector2.RIGHT * 5 * tile.power

func _on_ClearButton_click(el):
	active_tile.clear()

func _on_DestroyButton_click(el):
	active_tile.destroy()
