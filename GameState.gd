## In-game values
## Autoloaded
extends Node

# stats
var money := 1
var nb_extractors := 0
var nb_burners := 0
var nb_cutters := 0
var nb_factories := 0
var nb_assemblies := 0
var nb_sellers := 0
var has_won := false
var current_month := 0
var current_year := 70
var months_taken := 0

# limits -- can be upgraded
var max_extractors := 20
var max_burners := 10
var max_cutters := 10
var max_factories := 10
var max_assemblies := 5
var max_sellers := 3

var tutorial_focused := false

# lab upgrades
var upgrades := {
	Constants.UpgradeType.EXTRACTORS: 0,
	Constants.UpgradeType.PROCESSORS: 0,
	Constants.UpgradeType.ASSEMBLERS: 0,
	Constants.UpgradeType.FACTORY: 0,	
}

signal money_change
signal upgraded
signal game_won

func reset() -> void:
	money = 1
	nb_extractors = 0
	nb_burners = 0
	nb_cutters = 0
	nb_factories = 0
	nb_assemblies = 0
	nb_sellers = 0
	has_won = false
	current_month = 0
	current_year = 70
	months_taken = 0
	max_extractors = 20
	max_burners = 10
	max_cutters = 10
	max_factories = 10
	max_assemblies = 5
	max_sellers = 3
	tutorial_focused = false
	upgrades = {
		Constants.UpgradeType.EXTRACTORS: 0,
		Constants.UpgradeType.PROCESSORS: 0,
		Constants.UpgradeType.ASSEMBLERS: 0,
		Constants.UpgradeType.FACTORY: 0,	
	}
	WorldObjects.reset()
	WorldTiles.reset()

func upgrade(type: int) -> void:
	var level = upgrades[type]
	var price : int = Constants.UpgradePrices[type][level]
	money -= price
	emit_signal("money_change")
	if upgrades[type] < 5:
		upgrades[type] += 1
	max_extractors = (upgrades[Constants.UpgradeType.FACTORY] + 1) * 20
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
	if nb < Constants.FREE_MACHINES:
		return 0
	return (nb-Constants.FREE_MACHINES)

func income(cash: int) -> void:
	money += cash
	emit_signal("money_change")
	if money > Constants.MONEY_TO_WIN and not has_won:
		has_won = true
		yield(get_tree().create_timer(2.0), "timeout")
		emit_signal("game_won")
