extends Node

const MAX_UPGRADES = 5

# stats
var money = 0
var nb_extractors = 0
var nb_burners = 0
var nb_cutters = 0
var nb_factories = 0
var nb_assemblies = 0
var nb_sellers = 0

# limits -- can be upgraded
var max_extractors = 3
var max_burners = 3
var max_cutters = 3
var max_factories = 3
var max_assemblies = 3
var max_sellers = 3

# lab upgrades
var max_extractors_upgrade = 0
var max_burners_upgrade = 0
var max_cutters_upgrade = 0
var max_factories_upgrade = 0
var max_assemblies_upgrade = 0

var extractor_power_upgrade = 0
var burner_power_upgrade = 0
var cutter_power_upgrade = 0
var factories_power_upgrade = 0
var assemblies_power_upgrade = 0
var belt_power_upgrade = 0
