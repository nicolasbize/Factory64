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
var upgrades := {
	Constants.UpgradeType.EXTRACTORS: 0,
	Constants.UpgradeType.PROCESSORS: 0,
	Constants.UpgradeType.ASSEMBLERS: 0,
	Constants.UpgradeType.FACTORY: 0,	
}

signal money_change
signal upgraded

func upgrade(type: int) -> void:
	var level = upgrades[type]
	var price : int = Constants.UpgradePrices[type][level]
	money -= price
	emit_signal("money_change")
	if upgrades[type] < 5:
		upgrades[type] += 1
	max_extractors = (upgrades[Constants.UpgradeType.FACTORY] + 1) * 10
	max_burners = (upgrades[Constants.UpgradeType.FACTORY] + 1) * 10
	max_cutters = (upgrades[Constants.UpgradeType.FACTORY] + 1) * 10
	max_factories = (upgrades[Constants.UpgradeType.FACTORY] + 1) * 10
	max_assemblies = (upgrades[Constants.UpgradeType.FACTORY] + 1) * 5
	max_sellers = (upgrades[Constants.UpgradeType.FACTORY] + 1) * 3
	emit_signal("upgraded", type, upgrades[type])

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
