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
var history := []
var history_diffs := []
var history_trend_avg := 0
var prev_tick_money := GameState.money
var months_before_retirement := 50 * 12

signal game_tick

func _ready() -> void:
	GameState.connect("money_change", self, "refresh_money_text")
	history.push_front(GameState.money)

func refresh_date_text() -> void:
	var year := str(GameState.current_year)
	if year.length() == 1:
		year = "0" + year
	date.text = months[GameState.current_month] + year
	months_before_retirement -= 1
	var years_left := months_before_retirement / 12
	var months_left := months_before_retirement - years_left * 12	
	date_tooltip.tooltip_text = "%d yr %d mo before retirement!" % [years_left, months_left]

func _on_GameTimer_timeout() -> void:
	if GameState.game_started:
		update_money()
		update_date()
		emit_signal("game_tick")
		

func update_date() -> void:
	# TODO: move to gamestate
	GameState.months_taken += 1
	GameState.current_month += 1
	if GameState.current_month == months.size():
		GameState.current_month = 0
		GameState.current_year += 1
	if GameState.current_year == 100:
		GameState.current_year = 0
	refresh_date_text()

func update_money() -> void:
#	pay_factory_cost()
	history_diffs.append(GameState.money - history[-1])
	history.append(GameState.money)
	if history_diffs.size() > 2:
		# avg the last 3 history_diffs
		history_trend_avg = int((history_diffs[-1] + history_diffs[-2] + history_diffs[-3]) / 3)
		money_trend.visible = true
		if history_trend_avg  > 0:
			money_trend.frame = 0
			money.set("custom_colors/font_color", Color("3eba42"))
		elif history_trend_avg < 0:
			money_trend.frame = 1
			money.set("custom_colors/font_color", Color("ba3e3e"))
		else:
			money_trend.visible = false
	refresh_money_text()

func refresh_money_text() -> void:
	money.text = Utils.usd_to_str(GameState.money)
	var diff := history_trend_avg
	var monthly_income := Utils.usd_to_str(diff)
	var signed := "-" if diff < 0 else "+"
	money_tooltip.tooltip_text = signed + monthly_income + "/mo avg\nReach 1M to win"

#func pay_factory_cost() -> void:
#	var cost := 0
#	for i in range(GameState.get_next_price()):
#		cost += i
#	GameState.money -= cost

