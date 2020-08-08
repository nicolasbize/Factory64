extends "res://Tiles/Belts/BaseConveyorTile.gd"

const SilverPlate = preload("res://Objects/Plates/SilverPlate.tscn")
const IronPlate = preload("res://Objects/Plates/IronPlate.tscn")
const SiliconPlate = preload("res://Objects/Plates/SiliconPlate.tscn")
const GoldPlate = preload("res://Objects/Plates/GoldPlate.tscn")
const SilverWire = preload("res://Objects/Wires/SilverWire.tscn")
const IronWire = preload("res://Objects/Wires/IronWire.tscn")
const SiliconWire = preload("res://Objects/Wires/SiliconWire.tscn")
const GoldWire = preload("res://Objects/Wires/GoldWire.tscn")
const Battery = preload("res://Objects/Components/Battery.tscn")
const Capacitor = preload("res://Objects/Components/Capacitor.tscn")
const Chip = preload("res://Objects/Components/Chip.tscn")
const Circuit = preload("res://Objects/Components/Circuit.tscn")
const Diode = preload("res://Objects/Components/Diode.tscn")
const Inductor = preload("res://Objects/Components/Inductor.tscn")
const Relay = preload("res://Objects/Components/Relay.tscn")
const Resistor = preload("res://Objects/Components/Resistor.tscn")
const Transistor = preload("res://Objects/Components/Transistor.tscn")
const Computer = preload("res://Objects/Products/Computer.tscn")
const CPU = preload("res://Objects/Products/CPU.tscn")
const Fan = preload("res://Objects/Products/Fan.tscn")
const GPU = preload("res://Objects/Products/GPU.tscn")
const Monitor = preload("res://Objects/Products/Monitor.tscn")
const Motherboard = preload("res://Objects/Products/Motherboard.tscn")
const Phone = preload("res://Objects/Products/Phone.tscn")
const PSU = preload("res://Objects/Products/PSU.tscn")
const Radio = preload("res://Objects/Products/Radio.tscn")
const Memory = preload("res://Objects/Products/Memory.tscn")
const Speaker = preload("res://Objects/Products/Speaker.tscn")

enum {PENDING, POWERUP, BUSY, POWERDOWN }

onready var storage_area = $StorageArea
onready var process_timer = $ProcessTimer

var max_item_count = 10
var currently_processing = null
var currently_stored = null
var status = PENDING
var contents = [] # array of quantity per object types
export (int) var process_speed = 5
export (bool) var destroy_invalid_inputs = true

signal storage_change(storage)

func _ready():
	for i in range(Constants.ObjectType.size()):
		contents.append(0)

func _process(delta):
	if status == PENDING:
		animationPlayer.play("Pending")
	elif status == POWERUP:
		animationPlayer.play("PowerUp")
	elif status == POWERDOWN:
		animationPlayer.play("PowerDown")
	elif status == BUSY:
		animationPlayer.play("Busy")

func _on_TileTimer_timeout():
	if status == PENDING:
		store_contents()

	if currently_stored != null:
		# can we dispose of it?
		var spot = get_next_open_spot()
		if spot != null:
			var item = create_item_from_object_type(currently_stored)
			expulse(item, spot)
	else:
		var type_to_create = get_recipe_match()
		if type_to_create != null:
			use_ingredients_for_recipe(type_to_create)
			currently_processing = type_to_create
			status = POWERUP

func get_recipe_match():
	var outputs = get_list_valid_outputs()
	for output_type in outputs:
		var ingredients = Recipe.book.get(output_type)
		var has_all_ingredients = true
		for ingredient in ingredients:
			var required_type = ingredient.get("type")
			var required_quantity = ingredient.get("quantity")
			if contents[required_type] < required_quantity:
				has_all_ingredients = false
		if has_all_ingredients:
			return output_type
	return null

func use_ingredients_for_recipe(type):
	var ingredients = Recipe.book.get(type)
	for ingredient in ingredients:
		var required_type = ingredient.get("type")
		var required_quantity = ingredient.get("quantity")
		contents[required_type] -= required_quantity

func get_next_open_spot():
	var target_tile = null
	var spot = null
	if direction == Facing.RIGHT:
		spot = global_position + Vector2.RIGHT * 4
	elif direction == Facing.LEFT:
		spot = global_position + Vector2.LEFT * 4
	elif direction == Facing.UP:
		spot = global_position + Vector2.UP * 4
	else:
		spot = global_position + Vector2.DOWN * 4	
	target_tile = WorldTiles.get_at(spot)
	if target_tile != null and target_tile.is_valid_obj_pos(spot) and not WorldObjects.has_at(spot):
		return spot
	else:
		return null

func create_item_from_object_type(obj_type):
	var created_item = null
	match obj_type:
		Constants.ObjectType.SILVER_PLATE:
			created_item = SilverPlate.instance()
		Constants.ObjectType.SILICON_PLATE:
			created_item = SiliconPlate.instance()
		Constants.ObjectType.GOLD_PLATE:
			created_item = GoldPlate.instance()
		Constants.ObjectType.IRON_PLATE:
			created_item = IronPlate.instance()
		Constants.ObjectType.SILVER_WIRE:
			created_item = SilverWire.instance()
		Constants.ObjectType.SILICON_WIRE:
			created_item = SiliconWire.instance()
		Constants.ObjectType.GOLD_WIRE:
			created_item = GoldWire.instance()
		Constants.ObjectType.IRON_WIRE:
			created_item = IronWire.instance()
		Constants.ObjectType.BATTERY:
			created_item = Battery.instance()
		Constants.ObjectType.CAPACITOR:
			created_item = Capacitor.instance()
		Constants.ObjectType.CHIP:
			created_item = Chip.instance()
		Constants.ObjectType.CIRCUIT:
			created_item = Circuit.instance()
		Constants.ObjectType.DIODE:
			created_item = Diode.instance()
		Constants.ObjectType.INDUCTOR:
			created_item = Inductor.instance()
		Constants.ObjectType.RELAY:
			created_item = Relay.instance()
		Constants.ObjectType.RESISTOR:
			created_item = Resistor.instance()
		Constants.ObjectType.TRANSISTOR:
			created_item = Transistor.instance()
		Constants.ObjectType.COMPUTER:
			created_item = Computer.instance()
		Constants.ObjectType.CPU:
			created_item = CPU.instance()
		Constants.ObjectType.FAN:
			created_item = Fan.instance()
		Constants.ObjectType.GPU:
			created_item = GPU.instance()
		Constants.ObjectType.MONITOR:
			created_item = Monitor.instance()
		Constants.ObjectType.MOTHERBOARD:
			created_item = Motherboard.instance()
		Constants.ObjectType.PHONE:
			created_item = Phone.instance()
		Constants.ObjectType.PSU:
			created_item = PSU.instance()
		Constants.ObjectType.RADIO:
			created_item = Radio.instance()
		Constants.ObjectType.MEMORY:
			created_item = Memory.instance()
		Constants.ObjectType.SPEAKER:
			created_item = Speaker.instance()
	created_item.set_type(obj_type)
	return created_item
	
func expulse(item, pos):
	var main = get_tree().current_scene.find_node("MovingObjects", false, false)
	main.add_child(item)
	main.move_child(item, 0)
	item.global_position = pos
	WorldObjects.add(item, pos)
	currently_stored = null

func store_contents():
	var items = storage_area.get_overlapping_areas()
	for item in items:
		if item != self:
			# destroy non-ore items
			if item.type == null or should_destroy_item(item):
				print("should destroy")
				destroy_obj(item)
			elif contents[item.type] < max_item_count:
				contents[item.type] += 1
				emit_signal("storage_change", contents)
				destroy_obj(item)

func should_destroy_item(item):
	return (not get_list_valid_inputs().has(item.type)) and destroy_invalid_inputs

func destroy_obj(item):
	item.queue_free()
	WorldObjects.destroy(item)

func _on_PowerUp_done():
	status = BUSY
	process_timer.start(process_speed - get_tile_upgrade() - power)

func _on_PowerDown_done():
	status = PENDING
	currently_stored = currently_processing
	currently_processing = null

func _on_ProcessTimer_timeout():
	status = POWERDOWN
	process_timer.stop()

func get_list_valid_inputs():
	var input_types = []
	for output in get_list_valid_outputs():
		for input_type in Recipe.book.get(output):
			input_types.append(input_type.get("type"))
	return input_types

func get_tile_upgrade():
	return 0

func get_list_valid_outputs():
	print("not implemented by parent class")	
