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
onready var cursor := $UI/CustomCursor
onready var game_tiles := $Tiles
onready var selector := $Selector
onready var ui := $UI

enum Size {Small, Medium, Large}

export (bool) var is_pixel_perfect_mouse := true
export (Size) var size := Size.Small

var active_tile_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	randomize()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_mouse()
	if is_mouse_over_top_bar() or cursor.is_dragging:
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
	
func update_mouse() -> void:
	# chop on purpose
	var p = get_viewport().get_mouse_position()
	if is_pixel_perfect_mouse:
		cursor.global_position = Vector2(floor(p.x), floor(p.y))
	else:
		cursor.global_position = p	

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
	return pos.x > 0 and pos.x < 160 and pos.y > 15 and pos.y < 160

func show_tile_menu() -> void:
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
				tile.set_power(GameState.extractor_power_upgrade)
			Constants.TileType.GOLD:
				tile = GoldExtractorTile.instance()
				tile.set_power(GameState.extractor_power_upgrade)
			Constants.TileType.SILICON:
				tile = SiliconExtractorTile.instance()
				tile.set_power(GameState.extractor_power_upgrade)
			Constants.TileType.IRON:
				tile = IronExtractorTile.instance()
				tile.set_power(GameState.extractor_power_upgrade)
			Constants.TileType.BELT:
				tile = BeltTile.instance()
				tile.set_power(GameState.belt_power_upgrade)
			Constants.TileType.LBELT:
				tile = LBeltTile.instance()
				tile.set_power(GameState.belt_power_upgrade)
			Constants.TileType.TBELT:
				tile = TBeltTile.instance()
				tile.set_power(GameState.belt_power_upgrade)
			Constants.TileType.FURNACE:
				tile = FurnaceTile.instance()
				tile.set_power(GameState.burner_power_upgrade)
			Constants.TileType.CUTTER:
				tile = WireCutterTile.instance()
				tile.set_power(GameState.cutter_power_upgrade)
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
