## Game constants.
## Autoloaded
extends Node

const FREE_MACHINES = 20
const MAX_UPGRADES := 5
const MONEY_TO_WIN := 1000000

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
					60, 60, 80, 80,
					130, 160, 240, 250,
					380, 600, 600, 1200,
					3600, 9000, 14000, 17000,
					20000, 33000, 57000, 84000]
					
var ItemName := [
	"Iron ore",
	"Silver ore",
	"Silicon ore",
	"Gold ore",
	"Iron plate",
	"Silver plate",
	"Silicon plate",
	"Gold plate",
	"Iron wire",
	"Silver wire",
	"Silicon wire",
	"Gold wire",
	"Resistor",
	"Capacitor",
	"Transistor",
	"Inductor",
	"Diode",
	"Relay",
	"Battery",
	"Circuit",
	"Fan",
	"Chip",
	"Speaker",
	"Memory",
	"PSU",
	"CPU",
	"GPU",
	"Monitor",
	"Radio",
	"Motherboard",
	"Phone",
	"Computer",
]

enum UpgradeType {EXTRACTORS, PROCESSORS, ASSEMBLERS, FACTORY}
var UpgradePrices = [
	[3000, 8000, 20000, 50000], # extractors
	[3000, 8000, 20000, 50000], # processors
	[3000, 8000, 20000, 50000], # assemblers
	[5000, 20000, 50000, 100000], # factory
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
