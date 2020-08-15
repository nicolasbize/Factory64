## Bar at the top of the UI
class_name TopBar
extends Control

onready var date = $Date
onready var date_tooltip = $Date/DateTooltip
onready var money = $Money
onready var money_tooltip = $Money/MoneyTooltip
onready var money_trend = $MoneyTrend
onready var timer = $GameTimer

var months := ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
var prev_tick_money := GameState.money
var months_before_retirement := 50 * 12

signal game_tick

func _ready() -> void:
	refresh_money()
	refresh_date()
	GameState.connect("money_change", self, "refresh_money")

func refresh_money() -> void:
	money.text = Utils.usd_to_str(GameState.money)
	var diff := GameState.money - prev_tick_money
	var monthly_income := Utils.usd_to_str(diff)
	var signed := "-" if diff < 0 else "+"
	money_tooltip.tooltip_text = signed + monthly_income + "/mo\nReach 1M to win"

func refresh_date() -> void:
	date.text = months[GameState.current_month] + str(GameState.current_year)
	months_before_retirement -= 1
	var years_left := months_before_retirement / 12
	var months_left := months_before_retirement - years_left * 12	
	date_tooltip.tooltip_text = "%d yr %d mo before retirement!" % [years_left, months_left]

func _on_GameTimer_timeout() -> void:
	if GameState.game_started:
		GameState.months_taken += 1
		GameState.current_month += 1
		if GameState.current_month == months.size():
			GameState.current_month = 0
			GameState.current_year += 1
		if GameState.current_year == 100:
			GameState.current_year = 0
		update_money()
		refresh_date()
		emit_signal("game_tick")
		prev_tick_money = GameState.money

func update_money() -> void:
#	pay_factory_cost()
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
	
#func pay_factory_cost() -> void:
#	var cost := 0
#	for i in range(GameState.get_next_price()):
#		cost += i
#	GameState.money -= cost

