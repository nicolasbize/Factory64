extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

func _on_TileTimer_timeout():
	store_contents()

func store_contents():
	var items = storage_area.get_overlapping_areas()
	for item in items:
		if item != self:
			# destroy non-ore items
			if item.type != null:
				GameState.income(Constants.ObjectPrices[item.type])
			destroy_obj(item)
