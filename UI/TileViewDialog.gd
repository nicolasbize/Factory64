extends Control

onready var tick = $InfoPanel/Tick

func _on_LvlButton_click(lvl_sprite):
	tick.rect_global_position = lvl_sprite.rect_global_position + Vector2(1, -1)

