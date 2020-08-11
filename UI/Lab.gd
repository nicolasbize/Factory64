extends Control

onready var extractor_upgrade = $ExtractorUpgrade
onready var processor_upgrade = $ProcessorUpgrade
onready var assembly_upgrade = $AssemblyUpgrade
onready var factory_upgrade = $FactoryUpgrade

func refresh() -> void:
	for panel in [extractor_upgrade, processor_upgrade, assembly_upgrade, factory_upgrade]:
		panel.refresh()
