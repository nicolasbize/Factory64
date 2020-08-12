## A tile that sells items
class_name VendorTile
extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func _on_TileTimer_timeout() -> void:
	store_contents()

func store_contents() -> void:
	var items : Array = storage_area.get_overlapping_areas()
	for item in items:
		if item != self:
			# destroy non-ore items
			if item.type != null:
				GameState.income(Constants.ObjectPrices[item.type])
				operating_sound.play()
			destroy_obj(item)
