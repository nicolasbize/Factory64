extends Node

enum TileType {IRON, SILVER, SILICON, GOLD, BELT, LBELT, TBELT, FURNACE, CUTTER, FACTORY, ASSEMBLY, RESELLER}

enum Power {LOWEST, LOW, MEDIUM, HIGH, HIGHEST}

enum ObjectType {IRON_ORE, SILVER_ORE, SILICON_ORE, GOLD_ORE,
				 IRON_PLATE, SILVER_PLATE, SILICON_PLATE, GOLD_PLATE,
				 IRON_WIRE, SILVER_WIRE, SILICON_WIRE, GOLD_WIRE,
				 RESISTOR, CAPACITOR, TRANSISTOR, INDUCTOR,
				 DIODE, RELAY, BATTERY, CIRCUIT,
				 FAN, CHIP, SPEAKER, MEMORY,
				 PSU, CPU, GPU, MONITOR, RADIO, MOTHERBOARD, PHONE, COMPUTER }

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
