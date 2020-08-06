extends CanvasLayer

onready var tile_selector_modal = $TileSelectorModal
onready var tile_view_modal = $TileViewDialog
onready var selector_animator = $SelectorAnimationPlayer
onready var view_animator = $ViewAnimationPlayer

signal create_tile(tile_type)

var is_active = false setget set_active

func set_active(value):
	is_active = value

# Selector
func show_selector_modal():
	set_active(true)
	selector_animator.play("SlideUp")

func _on_selector_slide_up_complete():
	selector_animator.stop(true)

func _on_selector_slide_down_complete():
	set_active(false)
	selector_animator.stop(true)
	
func _on_selector_slide_left_complete():
	selector_animator.stop(true)
	
func _on_TileSelectorCloseButton_click(el):
	selector_animator.play("SlideDown")

func _on_TileSelectorAcceptButton_click(el):
	selector_animator.play("SlideDown")
	emit_signal("create_tile", tile_selector_modal.current_type)

# View modal
func show_view_modal(tile):
	set_active(true)
	view_animator.play("SlideLeft")

func _on_view_slide_left_complete():
	view_animator.stop(true)

func _on_view_slide_right_complete():
	set_active(false)
	view_animator.stop(true)	

func _on_TileViewCloseButton_click(el):
	view_animator.play("SlideRight")
