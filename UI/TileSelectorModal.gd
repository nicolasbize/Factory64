extends Control

enum {HIDDEN, SHOWING, HIDING, SHOWN}
var state := HIDDEN
var current_index = 0
var items = [{
	"frame": 4,
	"label": "extractor"
}, {
	"frame": 10,
	"label": "conveyor"
}, {
	"frame": 0,
	"label": "l section"
}, {
	"frame": 16,
	"label": "t section"
}, {
	"frame": 2,
	"label": "vendor"
}, {
	"frame": 34,
	"label": "burner"
}, {
	"frame": 26,
	"label": "cutter"
}, {
	"frame": 18,
	"label": "factory"
}]
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
	tile_sprite.frame = items[current_index].frame
	tile_label.text = items[current_index].label

func select_previous():
	current_index -= 1
	if current_index < 0:
		current_index = 0
	refresh_ui() 

func select_next():
	current_index += 1
	if current_index > items.size() - 1:
		current_index = items.size() - 1
	refresh_ui()

func _on_LeftButton_click():
	select_previous()

func _on_RightButton_click():
	select_next()

func _on_AcceptButton_click():
	emit_signal("tile_purchased", items[current_index].label)
