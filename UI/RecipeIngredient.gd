extends Control

onready var tooltip = $ObjectSprite/TooltipTrigger
onready var sprite = $ObjectSprite

func _on_ObjectSprite_frame_changed():
	tooltip.tooltip_text = Constants.ItemTooltips[sprite.frame]
