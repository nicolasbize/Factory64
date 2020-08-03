extends Control

enum {HIDDEN, SHOWING, HIDING, SHOWN}
var state := HIDDEN
var current_type = Constants.TileType.IRON

onready var animation_player = $AnimationPlayer
onready var left_button = $SelectionPanel/Panel/LeftButton
onready var right_button = $SelectionPanel/Panel/RightButton
onready var tile_sprite = $SelectionPanel/Panel/TileSprite
onready var tile_label = $SelectionPanel/Panel/TileLabel
onready var selection_panel = $SelectionPanel

signal tile_purchased

func _ready():
	refresh_ui()

func _process(delta):
	if state == SHOWING:
		animation_player.play("Appear")
	elif state == HIDING:
		animation_player.play("Hide")
		
func show():
	state = SHOWING

func hide():
	state = HIDING

func on_complete_hiding():
	animation_player.stop()
	state = HIDDEN

func on_complete_showing():
	animation_player.stop()
	state = SHOWN

func is_active():
	return state != HIDDEN

func refresh_ui():
	tile_sprite.frame = current_type
	tile_label.text = Constants.get_tile_name(current_type)

func select_previous():
	current_type -= 1
	if current_type < 0:
		current_type = 0
	refresh_ui() 

func select_next():
	current_type += 1
	if current_type > 10:
		current_type = 10
	refresh_ui()

func _on_LeftButton_click():
	select_previous()

func _on_RightButton_click():
	select_next()

func _on_AcceptButton_click():
	emit_signal("tile_purchased", current_type)
