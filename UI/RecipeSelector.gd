## Selects a recipe for a factory or assembly
class_name RecipeSelector
extends Control

onready var ingredient1 = $RecipeIngredient1
onready var ingredient1_sprite = $RecipeIngredient1/ObjectSprite
onready var ingredient1_tooltip = $RecipeIngredient1/TooltipTrigger
onready var ingredient2 = $RecipeIngredient2
onready var ingredient2_sprite = $RecipeIngredient2/ObjectSprite
onready var ingredient2_tooltip = $RecipeIngredient2/TooltipTrigger
onready var ingredient3 = $RecipeIngredient3
onready var ingredient3_sprite = $RecipeIngredient3/ObjectSprite
onready var ingredient3_tooltip = $RecipeIngredient3/TooltipTrigger
onready var output_sprite = $Output/ObjectSprite
onready var output_tooltip = $Output/TooltipTrigger
onready var progress1 = $RecipeIngredient1/ProgressSprite
onready var progress2 = $RecipeIngredient2/ProgressSprite
onready var progress3 = $RecipeIngredient3/ProgressSprite
onready var tracker1 = $RecipeIngredient1/TrackerSprite
onready var tracker2 = $RecipeIngredient2/TrackerSprite
onready var tracker3 = $RecipeIngredient3/TrackerSprite

var recipes := []
var current_index := 0
var current_storage := []
var item_els := []
var sprite_els := []
var tracker_els := []
var progress_els := []
var tooltip_els := []

signal change_recipe(type)

func _ready() -> void:
	item_els = [ingredient1, ingredient2, ingredient3]
	tooltip_els = [ingredient1_tooltip, ingredient2_tooltip, ingredient3_tooltip]
	sprite_els = [ingredient1_sprite, ingredient2_sprite, ingredient3_sprite]
	tracker_els = [tracker1, tracker2, tracker3]
	progress_els = [progress1, progress2, progress3]
	current_storage = []
	for _i in range(Constants.ObjectType.size()):
		current_storage.append(0)

func init(output_types: Array) -> void:
	recipes = []
	recipes += output_types
	current_index = 0
	refresh_ui(current_storage)
	
func refresh_ui(storage: Array) -> void:
	current_storage = storage
	var current_recipe : int = recipes[current_index]
	output_sprite.frame = current_recipe
	var output_name : String = Constants.ItemName[current_recipe]
	var output_price := Utils.usd_to_str(Constants.ObjectPrices[current_recipe])
	output_tooltip.tooltip_text = "%s\nSells for: %s" % [output_name, output_price]
	var ingredients : Array = Recipe.book.get(current_recipe)
	ingredient3.visible = false
	if ingredients.size() == 3:
		ingredient3.visible = true
	for i in range(ingredients.size()):
		var ingredient : Dictionary = ingredients[i]
		var type : int = ingredient.get("type")
		sprite_els[i].frame = type
		var required_quantity : int = ingredient.get("quantity")
		var current_quantity := min(storage[type], required_quantity)
		tracker_els[i].scale.x = required_quantity
		progress_els[i].scale.x = current_quantity
		var name : String = Constants.ItemName[type]
		tooltip_els[i].tooltip_text = "%s\nRequired: %d" % [name, required_quantity]

func _on_LeftButton_click(_el: ClickableButton) -> void:
	current_index -= 1
	if current_index < 0:
		current_index = 0
	refresh_ui(current_storage)
	emit_signal("change_recipe", recipes[current_index])

func _on_RightButton_click(_el: ClickableButton) -> void:
	current_index += 1
	if current_index > recipes.size() - 1:
		current_index = recipes.size() - 1
	refresh_ui(current_storage)
	emit_signal("change_recipe", recipes[current_index])

func set_recipe(recipe: int) -> void:
	current_index = recipes.find(recipe)
	refresh_ui(current_storage)
