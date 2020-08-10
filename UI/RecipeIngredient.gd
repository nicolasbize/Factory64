## A UI element representing an ObjectItem
class_name RecipeIngredient
extends Control

onready var tooltip := $ObjectSprite/TooltipTrigger
onready var sprite := $ObjectSprite

func _on_ObjectSprite_frame_changed() -> void:
	tooltip.tooltip_text = Constants.ItemTooltips[sprite.frame]
