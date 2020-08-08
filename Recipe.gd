extends Node

var book = {
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
	Constants.ObjectType.BATTERY: [{
		"type": Constants.ObjectType.SILVER_PLATE,
		"quantity": 3
	}, {
		"type": Constants.ObjectType.GOLD_WIRE,
		"quantity": 3
	}],
	Constants.ObjectType.CAPACITOR: [{
		"type": Constants.ObjectType.IRON_PLATE,
		"quantity": 4
	}, {
		"type": Constants.ObjectType.GOLD_WIRE,
		"quantity": 2
	}],
	Constants.ObjectType.RESISTOR: [{
		"type": Constants.ObjectType.IRON_WIRE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.SILICON_PLATE,
		"quantity": 1
	}],
	Constants.ObjectType.TRANSISTOR: [{
		"type": Constants.ObjectType.SILICON_WIRE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.SILVER_PLATE,
		"quantity": 1
	}],
	# Combination of plates/wires + simple components
	Constants.ObjectType.DIODE: [{
		"type": Constants.ObjectType.SILICON_WIRE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.SILVER_PLATE,
		"quantity": 1
	}],
	Constants.ObjectType.INDUCTOR: [{
		"type": Constants.ObjectType.SILICON_WIRE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.SILVER_PLATE,
		"quantity": 1
	}],
	Constants.ObjectType.RELAY: [{
		"type": Constants.ObjectType.SILICON_WIRE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.SILVER_PLATE,
		"quantity": 1
	}],
	
	# Complex 
	Constants.ObjectType.CIRCUIT: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}],
	Constants.ObjectType.CHIP: [{
		"type": Constants.ObjectType.RESISTOR,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.INDUCTOR,
		"quantity": 1
	}],
	Constants.ObjectType.FAN: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}],
	Constants.ObjectType.SPEAKER: [{
		"type": Constants.ObjectType.RESISTOR,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.INDUCTOR,
		"quantity": 1
	}],
	Constants.ObjectType.MEMORY: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}],
	
	# Very complex

	Constants.ObjectType.PSU: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}, {
		"type": Constants.ObjectType.RESISTOR,
		"quantity": 2
	}],
	Constants.ObjectType.CPU: [{
		"type": Constants.ObjectType.RESISTOR,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.INDUCTOR,
		"quantity": 1
	}],
	Constants.ObjectType.GPU: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}],
	Constants.ObjectType.MONITOR: [{
		"type": Constants.ObjectType.RESISTOR,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.INDUCTOR,
		"quantity": 1
	}],
	Constants.ObjectType.RADIO: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}],	
	Constants.ObjectType.MOTHERBOARD: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}],	
	Constants.ObjectType.PHONE: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}],	
	Constants.ObjectType.COMPUTER: [{
		"type": Constants.ObjectType.DIODE,
		"quantity": 2
	}, {
		"type": Constants.ObjectType.TRANSISTOR,
		"quantity": 1
	}]
}
