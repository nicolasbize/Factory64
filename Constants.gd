## Game constants.
## Autoloaded
extends Node

enum TileType {NONE=-1, IRON, SILVER, SILICON, GOLD, BELT, LBELT, TBELT, FURNACE, CUTTER, FACTORY, ASSEMBLY, RESELLER}
var TileCosts := [30,   30,     30,      30,   0,    0,     0,     80,      80,     100,     200,      200]
var TileTooltips := [
	"Extracts iron.",
	"Extracts silver.",
	"Extracts silicon.",
	"Extracts gold.",
	"Straight conveyor belt",
	"L-turn conveyor belt",
	"T-turn conveyor belt",
	"Turns ore into plates.",
	"Turns ore into wires.",
	"Creates components.",
	"Assembles products.",
	"Sells items.",
]
var TileProcessTooltips := [
	"In: none\nOut: Iron ore",
	"In: none\nOut: Silver ore",
	"In: none\nOut: Silicon ore",
	"In: none\nOut: Gold ore",
	"","","",
	"In: Ore\nOut: Plate",
	"In: Ore\nOut: Wire",
	"In: 2 items\nOut: Component",
	"In: 3 items\nOut: Product",
	"In: Anything\nOut: Money",
]

enum Power {LOWEST, LOW, MEDIUM, HIGH, HIGHEST}
enum ObjectSize {SMALL, MEDIUM, LARGE}
enum ObjectType {NONE=-1, IRON_ORE, SILVER_ORE, SILICON_ORE, GOLD_ORE,
				 IRON_PLATE, SILVER_PLATE, SILICON_PLATE, GOLD_PLATE,
				 IRON_WIRE, SILVER_WIRE, SILICON_WIRE, GOLD_WIRE,
				 RESISTOR, CAPACITOR, TRANSISTOR, INDUCTOR,
				 DIODE, RELAY, BATTERY, CIRCUIT,
				 FAN, CHIP, SPEAKER, MEMORY,
				 PSU, CPU, GPU, MONITOR, RADIO, MOTHERBOARD, PHONE, COMPUTER }
var ObjectPrices := [
					0, 0, 0, 0,
					10, 10, 10, 10,
					10, 10, 10, 10,
					50, 50, 60, 60,
					100, 160, 200, 220,
					320, 500, 500, 1000,
					3000, 7500, 11500, 14000,
					16500, 27500, 47000, 70000]
var ItemTooltips := [
	"Iron ore\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.IRON_ORE])],
	"Silver ore\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.SILVER_ORE])],
	"Silicon ore\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.SILICON_ORE])],
	"Gold ore\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.GOLD_ORE])],
	"Iron plate\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.IRON_PLATE])],
	"Silver plate\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.SILVER_PLATE])],
	"Silicon plate\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.SILICON_PLATE])],
	"Gold plate\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.GOLD_PLATE])],
	"Iron wire\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.IRON_WIRE])],
	"Silver wire\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.SILVER_WIRE])],
	"Silicon wire\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.SILICON_WIRE])],
	"Gold wire\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.GOLD_WIRE])],
	"Resistor\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.RESISTOR])],
	"Capacitor\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.CAPACITOR])],
	"Transistor\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.TRANSISTOR])],
	"Inductor\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.INDUCTOR])],
	"Diode\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.DIODE])],
	"Relay\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.RELAY])],
	"Battery\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.BATTERY])],
	"Circuit\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.CIRCUIT])],
	"Fan\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.FAN])],
	"Chip\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.CHIP])],
	"Speaker\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.SPEAKER])],
	"Memory\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.MEMORY])],
	"PSU\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.PSU])],
	"CPU\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.CPU])],
	"GPU\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.GPU])],
	"Monitor\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.MONITOR])],
	"Radio\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.RADIO])],
	"Motherboard\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.MOTHERBOARD])],
	"Phone\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.PHONE])],
	"Computer\nPrice: %s" % [Utils.usd_to_str(ObjectPrices[ObjectType.COMPUTER])],

]

var FurnaceOutputs := [
	ObjectType.IRON_PLATE,
	ObjectType.SILVER_PLATE,
	ObjectType.SILICON_PLATE,
	ObjectType.GOLD_PLATE
]
var WireCutterOuputs := [
	ObjectType.IRON_WIRE,
	ObjectType.SILVER_WIRE,
	ObjectType.SILICON_WIRE,
	ObjectType.GOLD_WIRE
]

var FactoryOutputs := [
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

var AssemblyOutputs := [
	ObjectType.PSU,
	ObjectType.CPU,
	ObjectType.GPU,
	ObjectType.MONITOR,
	ObjectType.RADIO,
	ObjectType.MOTHERBOARD,
	ObjectType.PHONE,
	ObjectType.COMPUTER 
]
