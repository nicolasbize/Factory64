## In-game values
## Autoloaded
extends Node

const MAX_UPGRADES := 5

# stats
var money := 1000
var nb_extractors := 0
var nb_burners := 0
var nb_cutters := 0
var nb_factories := 0
var nb_assemblies := 0
var nb_sellers := 0

# limits -- can be upgraded
var max_extractors := 10
var max_burners := 10
var max_cutters := 10
var max_factories := 10
var max_assemblies := 5
var max_sellers := 3

# lab upgrades
var extractor_power_upgrade := 4
var burner_power_upgrade := 4
var cutter_power_upgrade := 4
var belt_power_upgrade := 4
var assembly_power_upgrade := 4

signal money_change

func boost_game() -> void:
	max_extractors = 30
	max_burners = 30
	max_cutters = 30
	max_factories = 30
	max_assemblies = 30
	max_sellers = 30
	extractor_power_upgrade = 4
	burner_power_upgrade = 0
	cutter_power_upgrade = 0
	belt_power_upgrade = 4
	assembly_power_upgrade = 4

func get_nb_machines() -> int:
	return nb_extractors + nb_burners + nb_cutters + nb_factories + \
		nb_assemblies + nb_sellers

func get_next_price() -> int:
	var nb = get_nb_machines()
	if nb < 10:
		return 0
	return (nb-10)

func income(cash: int) -> void:
	money += cash
	emit_signal("money_change")
