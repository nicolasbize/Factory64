## Parent UI class
class_name UI
extends CanvasLayer

onready var custom_cursor := $CustomCursor
onready var selector_animator := $SelectorAnimationPlayer
onready var tile_selector_modal := $TileSelectorModal
onready var tile_view_modal := $TileViewDialog
onready var tooltip_animator := $TooltipAnimator
onready var tooltip_text := $Tooltip/ColorRect/ColorRect/TooltipText
onready var view_animator := $ViewAnimationPlayer

var is_active := false setget set_active
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
		selector_animator.play("SlideDown")
		emit_signal("create_tile", tile_selector_modal.current_type)

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


# Tooltip
func show_tooltip(text: String) -> void:
	if not tooltip_visible:
		tooltip_text.text = text
		tooltip_animator.play("SlideDown")
		tooltip_visible = true

func hide_tooltip() -> void:
	if tooltip_visible:
		tooltip_visible = false
		tooltip_animator.play("SlideUp")

func _on_tooltip_slide_down_complete() -> void:
	tooltip_animator.stop(true)
	
func _on_tooltip_slide_up_complete() -> void:
	tooltip_animator.stop(true)
