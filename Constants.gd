extends Node

enum TileType {IRON, SILVER, SILICON, GOLD, BELT, LBELT, TBELT, FURNACE, CUTTER, FACTORY, ASSEMBLY, RESELLER}
var TileCosts=[30,   30,     30,      30,   0,    0,     0,     80,      80,     100,     200,      200]
var TileTooltips = [
	"Extracts iron.\nCost: %d/mo" % [TileCosts[TileType.IRON]],
	"Extracts silver.\nCost: %d/mo" % [TileCosts[TileType.SILVER]],
	"Extracts silicon.\nCost: %d/mo" % [TileCosts[TileType.SILICON]],
	"Extracts gold.\nCost: %d/mo" % [TileCosts[TileType.GOLD]],
	"Straight conveyor belt",
	"L-turn conveyor belt",
	"T-turn conveyor belt",
	"Turns ore into plates.\nCost: %d/mo" % [TileCosts[TileType.FURNACE]],
	"Turns ore into wires.\nCost: %d/mo" % [TileCosts[TileType.CUTTER]],
	"Creates components.\nCost: %d/mo" % [TileCosts[TileType.FACTORY]],
	"Assembles products.\nCost: %d/mo" % [TileCosts[TileType.ASSEMBLY]],
	"Sells items.\nCost: %d/mo" % [TileCosts[TileType.RESELLER]],
]


enum Power {LOWEST, LOW, MEDIUM, HIGH, HIGHEST}

enum ObjectType {IRON_ORE, SILVER_ORE, SILICON_ORE, GOLD_ORE,
				 IRON_PLATE, SILVER_PLATE, SILICON_PLATE, GOLD_PLATE,
				 IRON_WIRE, SILVER_WIRE, SILICON_WIRE, GOLD_WIRE,
				 RESISTOR, CAPACITOR, TRANSISTOR, INDUCTOR,
				 DIODE, RELAY, BATTERY, CIRCUIT,
				 FAN, CHIP, SPEAKER, MEMORY,
				 PSU, CPU, GPU, MONITOR, RADIO, MOTHERBOARD, PHONE, COMPUTER }
var ObjectPrices = [0, 0, 0, 0,
					10, 10, 10, 10,
					10, 10, 10, 10,
					100, 120, 150, 180,
					250, 300, 350, 400,
					700, 900, 1200, 1300,
					1500, 1750, 2000, 2500, 3000, 3600, 4500, 8000]


var FurnaceOutputs = [
	ObjectType.IRON_PLATE,
	ObjectType.SILVER_PLATE,
	ObjectType.SILICON_PLATE,
	ObjectType.GOLD_PLATE
]
var WireCutterOuputs = [
	ObjectType.IRON_WIRE,
	ObjectType.SILVER_WIRE,
	ObjectType.SILICON_WIRE,
	ObjectType.GOLD_WIRE
]

var FactoryOutputs = [
	ObjectType.RESISTOR,
	ObjectType.CAPACITOR,
	ObjectType.TRANSISTOR,
	ObjectType.INDUCTOR,
	ObjectType.DIODE,
	ObjectType.RELAY,
	ObjectType.BATTERY,
	ObjectType.CIRCUIT,
	ObjectType.FAN,
	ObjectType.CHIP,
	ObjectType.SPEAKER,
	ObjectType.MEMORY
]

var AssemblyOutputs = [
	ObjectType.PSU,
	ObjectType.CPU,
	ObjectType.GPU,
	ObjectType.MONITOR,
	ObjectType.RADIO,
	ObjectType.MOTHERBOARD,
	ObjectType.PHONE,
	ObjectType.COMPUTER 
]
