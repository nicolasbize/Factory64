## Simple UI component to upgrade a specific area
class_name UpgradePanel
extends Control

onready var animation_player = $AnimationPlayer
onready var price = $PurchaseButton/Price
onready var purchase_button = $PurchaseButton
onready var purchase_tooltip = $PurchaseButton/PurchaseTooltip

export (Constants.UpgradeType) var upgrade_type: int

var disabled: bool = false

func refresh() -> void:
	var upgrade_level : int = GameState.upgrades[upgrade_type]
	if upgrade_level > 3:
		purchase_button.visible = false
	else:
		var cost : int = Constants.UpgradePrices[upgrade_type][upgrade_level]
		price.text = Utils.usd_to_str(cost)
		if GameState.money < cost:
			animation_player.play("Disable")
			purchase_button.disable()
			purchase_tooltip.tooltip_text = "Not enough funds"
		else:
			animation_player.play("Enable")
			purchase_button.enable()
			purchase_tooltip.tooltip_text = "Click to purchase"			

func _on_PurchaseButton_click(_el: InputEvent) -> void:
	GameState.upgrade(upgrade_type)
	refresh()
