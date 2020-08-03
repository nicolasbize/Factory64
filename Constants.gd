extends Node

enum TileType {IRON, SILVER, SILICON, GOLD, BELT, LBELT, TBELT, FURNACE, CUTTER, FACTORY, RESELLER}

func get_tile_name(type):
	match type:
		TileType.IRON: 
			return "Iron"
		TileType.SILVER:
			return "Silver"
		TileType.SILICON:
			return "Silicon"
		TileType.GOLD:
			return "Gold"
		TileType.BELT:
			return "Conveyor"
		TileType.LBELT:
			return "L-Conveyor"
		TileType.TBELT:
			return "T-Conveyor"
		TileType.FURNACE:
			return "Furnace"
		TileType.CUTTER:
			return "Cutter"
		TileType.FACTORY:
			return "Factory"
		TileType.RESELLER:
			return "Reseller"
