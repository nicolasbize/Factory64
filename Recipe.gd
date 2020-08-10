## List of recipes
## Autoloaded
extends Node

var book: Dictionary = {
	Constants.ObjectType.SILVER_PLATE: [{
		"type": Constants.ObjectType.SILVER_ORE,
		"quantity": 10
	}],
	Constants.ObjectType.GOLD_PLATE: [{
		"type": Constants.ObjectType.GOLD_ORE,
		"quantity": 10
	}],
	Constants.ObjectType.IRON_PLATE: [{
		"type": Constants.ObjectType.IRON_ORE,
		"quantity": 10
	}],
	Constants.ObjectType.SILICON_PLATE: [{
		"type": Constants.ObjectType.SILICON_ORE,
		"quantity": 10
	}],
	Constants.ObjectType.SILVER_WIRE: [{
		"type": Constants.ObjectType.SILVER_ORE,
		"quantity": 10
	}],
	Constants.ObjectType.GOLD_WIRE: [{
		"type": Constants.ObjectType.GOLD_ORE,
		"quantity": 10
	}],
	Constants.ObjectType.IRON_WIRE: [{
		"type": Constants.ObjectType.IRON_ORE,
		"quantity": 10
	}],
	Constants.ObjectType.SILICON_WIRE: [{
		"type": Constants.ObjectType.SILICON_ORE,
		"quantity": 10
	}],
	# SIMPLE COMPONENTS
	Constants.ObjectType.RESISTOR: [{
		"type": Constants.ObjectType.IRON_PLATE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.SILICON_WIRE,
		"quantity": 2
	}],
	Constants.ObjectType.CAPACITOR: [{
		"type": Constants.ObjectType.SILVER_PLATE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.GOLD_WIRE,
		"quantity": 2
	}],
	Constants.ObjectType.TRANSISTOR: [{
		"type": Constants.ObjectType.SILICON_PLATE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.IRON_WIRE,
		"quantity": 3
	}],
	Constants.ObjectType.INDUCTOR: [{
		"type": Constants.ObjectType.GOLD_PLATE,
		"quantity": 3
	}, {
		"type": Constants.ObjectType.SILVER_WIRE,
		"quantity": 2
	}],
	# Combination of plates/wires + simple components
	Constants.ObjectType.DIODE: [{
		"type": Constants.ObjectType.GOLD_PLATE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}],
	Constants.ObjectType.RELAY: [{
		"type": Constants.ObjectType.IRON_PLATE,
		"quantity": 1
	}, {
		"type": Constants.ObjectType.INDUCTOR,
		"quantity": 2
	}],
	Constants.ObjectType.BATTERY: [{
		"type": Constants.ObjectType.SILVER_PLATE,
		"quantity": 1
	}, {
		"type": Constants.ObjectType.RESISTOR,
		"quantity": 3
	}],
	Constants.ObjectType.CIRCUIT: [{
		"type": Constants.ObjectType.SILICON_PLATE,
		"quantity": 5
	}, {
		"type": Constants.ObjectType.CAPACITOR,
		"quantity": 3
	}],
	
	# 2x assembly with components only
	Constants.ObjectType.FAN: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 1
	}, {
		"type": Constants.ObjectType.RELAY,
		"quantity": 1
	}],
	Constants.ObjectType.CHIP: [{
		"type": Constants.ObjectType.BATTERY,
		"quantity": 1
	}, {
		"type": Constants.ObjectType.CIRCUIT,
		"quantity": 1
	}],
	Constants.ObjectType.SPEAKER: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.CIRCUIT,
		"quantity": 1
	}],
	Constants.ObjectType.MEMORY: [{
		"type": Constants.ObjectType.RELAY,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.CHIP,
		"quantity": 1
	}],
	
	# ASSEMBLY x3
	Constants.ObjectType.PSU: [{
		"type": Constants.ObjectType.CAPACITOR,
		"quantity": 6
	}, {
		"type": Constants.ObjectType.BATTERY,
		"quantity": 4
	}, {
		"type": Constants.ObjectType.FAN,
		"quantity": 4
	}],
	Constants.ObjectType.CPU: [{
		"type": Constants.ObjectType.CIRCUIT,
		"quantity": 4
	}, {
		"type": Constants.ObjectType.CHIP,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.MEMORY,
		"quantity": 4
	}],
	Constants.ObjectType.GPU: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 6
	}, {
		"type": Constants.ObjectType.CIRCUIT,
		"quantity": 4
	}, {
		"type": Constants.ObjectType.CPU,
		"quantity": 1
	}],
	Constants.ObjectType.MONITOR: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 4
	}, {
		"type": Constants.ObjectType.CPU,
		"quantity": 1
	}, {
		"type": Constants.ObjectType.PSU,
		"quantity": 1
	}],
	Constants.ObjectType.RADIO: [{
		"type": Constants.ObjectType.BATTERY,
		"quantity": 4
	}, {
		"type": Constants.ObjectType.SPEAKER,
		"quantity": 6
	}, {
		"type": Constants.ObjectType.PSU,
		"quantity": 3
	}],	
	Constants.ObjectType.MOTHERBOARD: [{
		"type": Constants.ObjectType.CIRCUIT,
		"quantity": 6
	}, {
		"type": Constants.ObjectType.MEMORY,
		"quantity": 5
	}, {
		"type": Constants.ObjectType.CPU,
		"quantity": 2
	}],	
	Constants.ObjectType.PHONE: [{
		"type": Constants.ObjectType.BATTERY,
		"quantity": 6
	}, {
		"type": Constants.ObjectType.SPEAKER,
		"quantity": 4
	}, {
		"type": Constants.ObjectType.RADIO,
		"quantity": 2
	}],	
	Constants.ObjectType.COMPUTER: [{
		"type": Constants.ObjectType.GPU,
		"quantity": 1
	}, {
		"type": Constants.ObjectType.MONITOR,
		"quantity": 1
	}, {
		"type": Constants.ObjectType.MOTHERBOARD,
		"quantity": 1
	}]
}
