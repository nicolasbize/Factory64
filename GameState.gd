## In-game values
## Autoloaded
extends Node

const MAX_UPGRADES := 5

# stats
var money := 100000
var nb_extractors := 0
var nb_burners := 0
var nb_cutters := 0
var nb_factories := 0
var nb_assemblies := 0
var nb_sellers := 0

# limits -- can be upgraded
var max_extractors := 3
var max_burners := 3
var max_cutters := 3
var max_factories := 3
var max_assemblies := 3
var max_sellers := 3

# lab upgrades
var extractor_power_upgrade := 0
var burner_power_upgrade := 0
var cutter_power_upgrade := 0
var factories_power_upgrade := 0
var belt_power_upgrade := 0
var assembly_power_upgrade := 0
var factory_power_upgrade := 0

signal money_change

func boost_game() -> void:
	max_extractors = 30
	max_burners = 30
	max_cutters = 30
	max_factories = 30
	max_assemblies = 30
	max_sellers = 30
	extractor_power_upgrade = 4
	burner_power_upgrade = 4
	cutter_power_upgrade = 4
	factories_power_upgrade = 4
	belt_power_upgrade = 4
	assembly_power_upgrade = 4
	factory_power_upgrade = 4

func income(cash: int) -> void:
	money += cash
	emit_signal("money_change")
