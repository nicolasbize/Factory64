extends Control

onready var extractor_upgrade = $Panel/ExtractorUpgrade
onready var processor_upgrade = $Panel/ProcessorUpgrade
onready var assembly_upgrade = $Panel/AssemblyUpgrade
onready var factory_upgrade = $Panel/FactoryUpgrade

func refresh() -> void:
	for panel in [extractor_upgrade, processor_upgrade, assembly_upgrade, factory_upgrade]:
		panel.refresh()
