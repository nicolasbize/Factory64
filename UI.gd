## Parent UI class
class_name UI
extends CanvasLayer

onready var lab = $Lab
onready var lab_animator := $LabAnimationPlayer
onready var selector_animator := $SelectorAnimationPlayer
onready var tile_selector_modal := $TileSelectorModal
onready var tile_view_modal := $TileViewDialog
onready var view_animator := $ViewAnimationPlayer

var is_active := false setget set_active
var showing_upgrades := false
var tooltip_visible := false

signal create_tile(tile_type)

func set_active(value: bool) -> void:
	is_active = value

# Selector
func show_selector_modal() -> void:
	set_active(true)
	tile_selector_modal.refresh_ui()
	selector_animator.play("SlideUp")

func _on_selector_slide_up_complete() -> void:
	selector_animator.stop(true)

func _on_selector_slide_down_complete() -> void:
	set_active(false)
	selector_animator.stop(true)
	
func _on_selector_slide_left_complete() -> void:
	selector_animator.stop(true)
	
func _on_TileSelectorCloseButton_click(_el: ClickableButton) -> void:
	selector_animator.play("SlideDown")

func _on_TileSelectorAcceptButton_click(_el: ClickableButton) -> void:
	if not tile_selector_modal.is_disabled:
		var type : int = tile_selector_modal.current_type
		selector_animator.play("SlideDown")
		var price := GameState.get_next_price()
		if type == Constants.TileType.BELT or type == Constants.TileType.LBELT or type == Constants.TileType.TBELT:
			price = 0
		emit_signal("create_tile", type, price)

# View modal
func show_view_modal(tile: Tile) -> void:
	set_active(true)
	tile_view_modal.set_tile(tile)
	view_animator.play("SlideLeft")

func _on_view_slide_left_complete() -> void:
	view_animator.stop(true)

func _on_view_slide_right_complete() -> void:
	set_active(false)
	view_animator.stop(true)	

func _on_TileViewCloseButton_click(_el: ClickableButton) -> void:
	view_animator.play("SlideRight")
	
func _on_TileDestroyButton_click(_el: ClickableButton) -> void:
	view_animator.play("SlideRight")

# Lab
func show_lab() -> void:
	showing_upgrades = true
	lab.refresh()
	lab_animator.play("SlideRight")

func _on_lab_slide_left_complete() -> void:
	showing_upgrades = false
	lab_animator.stop(true)

func _on_lab_slide_right_complete() -> void:
	lab_animator.stop(true)

func _on_Lab_Close_click(_el: ClickableButton) -> void:
	lab_animator.play("SlideLeft")

func _on_UpgradeButton_click(_el: ClickableButton) -> void:
	show_lab()
