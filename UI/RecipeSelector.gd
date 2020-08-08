extends Control

onready var ingredient1 = $RecipeIngredient1
onready var ingredient1_sprite = $RecipeIngredient1/ObjectSprite
onready var tracker1 = $RecipeIngredient1/TrackerSprite
onready var progress1 = $RecipeIngredient1/ProgressSprite
onready var ingredient2 = $RecipeIngredient2
onready var ingredient2_sprite = $RecipeIngredient2/ObjectSprite
onready var tracker2 = $RecipeIngredient2/TrackerSprite
onready var progress2 = $RecipeIngredient2/ProgressSprite
onready var ingredient3 = $RecipeIngredient3
onready var ingredient3_sprite = $RecipeIngredient3/ObjectSprite
onready var tracker3 = $RecipeIngredient3/TrackerSprite
onready var progress3 = $RecipeIngredient3/ProgressSprite
onready var output_sprite = $Output/ObjectSprite

var recipes = []
var current_index = 0
var current_storage = {}
var item_els = []
var sprite_els = []
var tracker_els = []
var progress_els = []

signal change_recipe(type)

func _ready():
	item_els = [ingredient1, ingredient2, ingredient3]
	sprite_els = [ingredient1_sprite, ingredient2_sprite, ingredient3_sprite]
	tracker_els = [tracker1, tracker2, tracker3]
	progress_els = [progress1, progress2, progress3]

func init(output_types):
	recipes = []
	recipes += output_types
	current_index = 0
	refresh_ui({})
	
func refresh_ui(storage):
	current_storage = storage
	var current_recipe = recipes[current_index]
	output_sprite.frame = current_recipe
	var ingredients = Recipe.book.get(current_recipe)
	ingredient3.visible = false
	if ingredients.size() == 3:
		ingredient3.visible = true
	for i in range(ingredients.size()):
		var ingredient = ingredients[i]
		var type = ingredient.get("type")
		sprite_els[i].frame = type
		tracker_els[i].scale.x = ingredient.get("quantity")
		progress_els[i].scale.x = storage.get(type) if storage.has(type) else 0


func _on_LeftButton_click(el):
	current_index -= 1
	if current_index < 0:
		current_index = 0
	refresh_ui(current_storage)
	emit_signal("change_recipe", current_index)

func _on_RightButton_click(el):
	current_index += 1
	if current_index > recipes.size() - 1:
		current_index = recipes.size() - 1
	refresh_ui(current_storage)
	emit_signal("change_recipe", current_index)
