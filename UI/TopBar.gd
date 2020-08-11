## Bar at the top of the UI
class_name TopBar
extends Control

const SECS_BETWEEN_MONTHS = 5

onready var date = $Date
onready var money = $Money
onready var money_trend = $MoneyTrend
onready var timer = $GameTimer

var current_month := 0
var current_year := 70
var months := ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
var prev_tick_money := GameState.money

signal game_tick

func _ready() -> void:
	timer.start(SECS_BETWEEN_MONTHS)
	money.text = Utils.usd_to_str(GameState.money)
	if GameState.connect("money_change", self, "refresh_money") != OK:
		push_error("TopBar could not connect to GameState")

func refresh_money() -> void:
	money.text = Utils.usd_to_str(GameState.money)

func _on_GameTimer_timeout() -> void:
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

func update_money() -> void:
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
	
func pay_factory_cost() -> void:
	var nb_machines := GameState.get_nb_machines()
	if nb_machines > 10:
		var cost := 0
		for i in range(GameState.get_nb_machines() - 9):
			cost += i
		GameState.money -= cost

