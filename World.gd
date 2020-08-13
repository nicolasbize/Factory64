## Main Game class, should not be instanced
extends Node

const AssemblyTile = preload("res://Tiles/Equipment/AssemblyTile.tscn")
const BeltTile = preload("res://Tiles/Belts/BeltTile.tscn")
const FactoryTile = preload("res://Tiles/Equipment/FactoryTile.tscn")
const FurnaceTile = preload("res://Tiles/OreProcessing/FurnaceTile.tscn")
const GoldExtractorTile = preload("res://Tiles/Extractors/GoldExtractorTile.tscn")
const IronExtractorTile = preload("res://Tiles/Extractors/IronExtractorTile.tscn")
const LBeltTile = preload("res://Tiles/Belts/LBeltTile.tscn")
const SiliconExtractorTile = preload("res://Tiles/Extractors/SiliconExtractorTile.tscn")
const SilverExtractorTile = preload("res://Tiles/Extractors/SilverExtractorTile.tscn")
const TBeltTile = preload("res://Tiles/Belts/TBeltTile.tscn")
const VendorTile = preload("res://Tiles/Equipment/VendorTile.tscn")
const WireCutterTile = preload("res://Tiles/OreProcessing/WireCutterTile.tscn")

onready var camera := $Camera2D
onready var factory_base := $"Factory-Base"
onready var factory_upgrade_1 := $"Factory-Upgrade-1"
onready var factory_upgrade_2 := $"Factory-Upgrade-2"
onready var factory_upgrade_3 := $"Factory-Upgrade-3"
onready var factory_upgrade_4 := $"Factory-Upgrade-4"
onready var game_tiles := $Tiles
onready var selector := $Selector
onready var ui := $UI
onready var top_ui := $TopUI

enum Size {Small, Medium, Large}

export (bool) var is_pixel_perfect_mouse := true
export (Size) var size := Size.Small

var active_tile_position: Vector2 = Vector2.ZERO
var cursor: GameCursor = null
var game_started := false
var world_start := Vector2(0, 15)
var world_end := Vector2.ZERO

func _ready() -> void:
	randomize()
	cursor = get_node("/root/LittleBigFactory/GameCursor")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	GameState.connect("upgraded", self, "_on_upgrade_purchased")
	refresh_world_tiles()

func start() -> void:
	game_started = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not game_started:
		return
	if (is_mouse_over_top_bar() or cursor.is_dragging or ui.showing_upgrades) and active_tile_position == Vector2.ZERO:
		selector.visible = false
	elif not ui.is_active:
		update_selector()
		if Input.is_action_just_pressed("ui_select") and is_valid_tile(selector.position):
			camera.move_to(selector.position)
			show_tile_menu()
		if Input.is_action_just_pressed("reverse") and is_valid_tile(selector.position):
			WorldTiles.reverse(selector.position)

func is_mouse_over_top_bar() -> bool:
	return get_viewport().get_mouse_position().y < 9

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and is_valid_tile(selector.position):
		if event.button_index == BUTTON_WHEEL_UP :
			WorldTiles.rotate(selector.position, -90)
		if event.button_index == BUTTON_WHEEL_DOWN:
			WorldTiles.rotate(selector.position, 90)

func update_selector() -> void:
	var mpos = camera.global_position + get_viewport().get_mouse_position()
	var mpos_x = round((mpos.x - 4) / 8) * 8
	var mpos_y = round((mpos.y - 4) / 8) * 8
	selector.global_position = Vector2(mpos_x, mpos_y)
	selector.visible = is_valid_tile(selector.position)

func is_valid_tile(pos: Vector2) -> bool:
	return pos.x > world_start.x and pos.x < world_end.x and pos.y > world_start.y and pos.y < world_end.y

func show_tile_menu() -> void:
	if not ui.showing_upgrades:
		active_tile_position = selector.position
		var tile = WorldTiles.get_at(active_tile_position)
		if tile == null:
			ui.show_selector_modal()
		else:
			ui.show_view_modal(tile)

func _on_UI_create_tile(tile_type: int) -> void:
	if WorldTiles.can_add(active_tile_position):
		var tile = null
		match tile_type:
			Constants.TileType.SILVER:
				tile = SilverExtractorTile.instance()
				tile.set_power(GameState.upgrades[Constants.UpgradeType.EXTRACTORS])
			Constants.TileType.GOLD:
				tile = GoldExtractorTile.instance()
				tile.set_power(GameState.upgrades[Constants.UpgradeType.EXTRACTORS])
			Constants.TileType.SILICON:
				tile = SiliconExtractorTile.instance()
				tile.set_power(GameState.upgrades[Constants.UpgradeType.EXTRACTORS])
			Constants.TileType.IRON:
				tile = IronExtractorTile.instance()
				tile.set_power(GameState.upgrades[Constants.UpgradeType.EXTRACTORS])
			Constants.TileType.BELT:
				tile = BeltTile.instance()
			Constants.TileType.LBELT:
				tile = LBeltTile.instance()
			Constants.TileType.TBELT:
				tile = TBeltTile.instance()
			Constants.TileType.FURNACE:
				tile = FurnaceTile.instance()
				tile.set_power(GameState.upgrades[Constants.UpgradeType.PROCESSORS])
			Constants.TileType.CUTTER:
				tile = WireCutterTile.instance()
				tile.set_power(GameState.upgrades[Constants.UpgradeType.PROCESSORS])
			Constants.TileType.FACTORY:
				tile = FactoryTile.instance()
			Constants.TileType.ASSEMBLY:
				tile = AssemblyTile.instance()
			Constants.TileType.RESELLER:
				tile = VendorTile.instance()
		
		game_tiles.add_child(tile)
		tile.global_position = active_tile_position + Vector2.ONE * 4
		tile.type = tile_type
		WorldTiles.add(tile, active_tile_position)

func _on_upgrade_purchased(type, level):
	match type:
		Constants.UpgradeType.PROCESSORS:
			for tile in WorldTiles.tiles.values():
				if tile.type == Constants.TileType.FURNACE or \
				tile.type == Constants.TileType.CUTTER:
					tile.set_power(level)
		Constants.UpgradeType.EXTRACTORS:
			for tile in WorldTiles.tiles.values():
				if tile.type == Constants.TileType.GOLD or \
				tile.type == Constants.TileType.IRON or \
				tile.type == Constants.TileType.SILICON or \
				tile.type == Constants.TileType.SILVER:
					tile.set_power(level)
		Constants.UpgradeType.FACTORY:
			refresh_world_tiles()
			 
func refresh_world_tiles():
	var upgrade : int = GameState.upgrades[Constants.UpgradeType.FACTORY]
	var worlds := [factory_base, factory_upgrade_1, factory_upgrade_2, factory_upgrade_3, factory_upgrade_4]
	for i in range(worlds.size()):
		worlds[i].visible = i == upgrade
	var size_x := (20 + 5*upgrade) * 8
	var size_y := (16 + 5*upgrade) * 8
	world_end = Vector2(size_x, size_y)
	camera.limit_right = (200 + 40 * upgrade)
	camera.limit_bottom = (160 + 40 * upgrade)
