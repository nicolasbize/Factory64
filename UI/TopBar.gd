extends Control

const SECS_BETWEEN_MONTHS = 5

onready var money = $Money
onready var money_trend = $MoneyTrend
onready var date = $Date
onready var timer = $GameTimer

var current_month = 0
var current_year = 70
var months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
var prev_tick_money = GameState.money

signal game_tick

func _ready():
	timer.start(SECS_BETWEEN_MONTHS)
	money.text = get_money_str(GameState.money)
	GameState.connect("money_change", self, "refresh_money")

func refresh_money():
	money.text = get_money_str(GameState.money)

func _on_GameTimer_timeout():
	current_month += 1
	if current_month == months.size():
		current_month = 0
		current_year += 1
	if current_year == 100:
		current_year = 0
	date.text = months[current_month] + str(current_year)
	pay_factory_cost()
	update_money()
	timer.start(SECS_BETWEEN_MONTHS)
	emit_signal("game_tick")

func update_money():
	money_trend.visible = true
	if GameState.money > prev_tick_money:
		money_trend.frame = 0
		money.set("custom_colors/font_color", Color("3eba42"))
	elif GameState.money < prev_tick_money:
		money_trend.frame = 1
		money.set("custom_colors/font_color", Color("ba3e3e"))
	else:
		money_trend.visible = false	
	refresh_money()
	
func get_money_str(amount):
	amount = abs(float(amount))
	if amount < 1e3:
		return "$" + str(amount)
	elif amount < 1e5:
		return "$" + str(amount / 1e3).left(4) + "K"
	elif amount < 1e6:
		return "$" + str(amount / 1e3).left(3) + "K"
	elif amount < 1e8:
		return "$" + str(amount / 1e6).left(4) + "M"
	elif amount < 1e9:
		return "$" + str(amount / 1e6).left(3) + "M"
	elif amount < 1e11:
		return "$" + str(amount / 1e9).left(4) + "B"
	elif amount < 1e12:
		return "$" + str(amount / 1e9).left(3) + "B"

func pay_factory_cost():
	var cost = 0
	for tile in WorldTiles.tiles.values():
		cost += Constants.TileCosts[tile.type] * tile.speed
	GameState.money -= cost
