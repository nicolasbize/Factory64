extends Node

onready var selector := $Selector
onready var tile_selector_modal := $TileSelectorModal
onready var game_tiles = $Tiles

var active_tile_position = null

const SilverExtractorTile = preload("res://Tiles/SilverExtractorTile.tscn")
const GoldExtractorTile = preload("res://Tiles/GoldExtractorTile.tscn")
const IronExtractorTile = preload("res://Tiles/IronExtractorTile.tscn")
const SiliconExtractorTile = preload("res://Tiles/SiliconExtractorTile.tscn")
const ConveyorTile = preload("res://Tiles/ConveyorTile.tscn")
const LConveyorTile = preload("res://Tiles/LConveyorTile.tscn")
const TConveyorTile = preload("res://Tiles/TConveyorBelt.tscn")
const VendorTile = preload("res://Tiles/VendorTile.tscn")
const FactoryTile = preload("res://Tiles/FactoryTile.tscn")
const BurnerTile = preload("res://Tiles/BurnerTile.tscn")
const CutterTile = preload("res://Tiles/CutterTile.tscn")

func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_selector()
	if not tile_selector_modal.is_active():	
		if Input.is_action_just_pressed("ui_select") and is_valid_tile(selector.position):
			show_tile_menu()
		if Input.is_action_just_pressed("reverse") and is_valid_tile(selector.position):
			WorldTiles.reverse(selector.position)

func _input(event):
	if event is InputEventMouseButton and event.pressed and is_valid_tile(selector.position):
		if event.button_index == BUTTON_WHEEL_UP :
			WorldTiles.rotate(selector.position, -90)
		if event.button_index == BUTTON_WHEEL_DOWN:
			WorldTiles.rotate(selector.position, 90)

func update_selector():
	var mpos := get_viewport().get_mouse_position()
	var mpos_x = round((mpos.x - 4) / 8) * 8
	var mpos_y = round((mpos.y - 4) / 8) * 8
	selector.position = Vector2(mpos_x, mpos_y)
	selector.visible = is_valid_tile(selector.position)

func is_valid_tile(pos):
	return pos.y > 1

func show_tile_menu():
	active_tile_position = selector.position
	tile_selector_modal.show()
	

func _on_TileSelectorModal_tile_purchased(tile_type):
	tile_selector_modal.hide()
	if WorldTiles.can_add(active_tile_position):
		var tile = null
		match tile_type:
			Constants.TileType.SILVER:
				tile = SilverExtractorTile.instance()
			Constants.TileType.GOLD:
				tile = GoldExtractorTile.instance()
			Constants.TileType.SILICON:
				tile = SiliconExtractorTile.instance()
			Constants.TileType.IRON:
				tile = IronExtractorTile.instance()
			Constants.TileType.BELT:
				tile = ConveyorTile.instance()
			Constants.TileType.LBELT:
				tile = LConveyorTile.instance()
			Constants.TileType.TBELT:
				tile = TConveyorTile.instance()
			Constants.TileType.FURNACE:
				tile = BurnerTile.instance()
			Constants.TileType.CUTTER:
				tile = CutterTile.instance()
			Constants.TileType.FACTORY:
				tile = FactoryTile.instance()
			Constants.TileType.RESELLER:
				tile = VendorTile.instance()
		
		game_tiles.add_child(tile)
		tile.global_position = active_tile_position + Vector2.ONE * 4
		WorldTiles.add(tile, active_tile_position)

func _on_TileSelectorCancelButton_click():
	tile_selector_modal.hide()

