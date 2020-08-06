extends Control

var current_type = Constants.TileType.IRON

onready var left_button = $SelectionPanel/Panel/LeftButton
onready var right_button = $SelectionPanel/Panel/RightButton
onready var tile_sprite = $SelectionPanel/Panel/TileSprite
onready var tile_label = $SelectionPanel/Panel/TileLabel
onready var selection_panel = $SelectionPanel

func _ready():
	refresh_ui()

func refresh_ui():
	tile_sprite.frame = current_type
	tile_label.text = Constants.get_tile_name(current_type)

func _on_LeftButton_click(el):
	current_type -= 1
	if current_type < 0:
		current_type = 0
	refresh_ui() 

func _on_RightButton_click(el):
	current_type += 1
	if current_type > 10:
		current_type = 10
	refresh_ui()
