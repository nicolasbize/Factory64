## Parent UI class
class_name TopUI
extends CanvasLayer

onready var tooltip_animator := $TooltipAnimator
onready var tooltip_text := $Tooltip/ColorRect/ColorRect/TooltipText

var tooltip_visible := false

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
