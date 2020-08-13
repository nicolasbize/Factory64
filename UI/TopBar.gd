## Bar at the top of the UI
class_name TopBar
extends Control

const SECS_BETWEEN_MONTHS = 5

onready var date = $Date
onready var date_tooltip = $Date/DateTooltip
onready var money = $Money
onready var money_tooltip = $Money/MoneyTooltip
onready var money_trend = $MoneyTrend
onready var timer = $GameTimer

var current_month := 0
var current_year := 70
var months := ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
var prev_tick_money := GameState.money
var months_before_retirement := 50 * 12

signal game_tick

func _ready() -> void:
	timer.start(SECS_BETWEEN_MONTHS)
	refresh_money()
	refresh_date()
	if GameState.connect("money_change", self, "refresh_money") != OK:
		push_error("TopBar could not connect to GameState")

func refresh_money() -> void:
	money.text = Utils.usd_to_str(GameState.money)
	money_tooltip.tooltip_text = "$" + str(GameState.money) + "\nReach 1M to win"

func refresh_date() -> void:
	date.text = months[current_month] + str(current_year)
	months_before_retirement -= 1
	var years_left := months_before_retirement / 12
	var months_left := months_before_retirement - years_left * 12	
	date_tooltip.tooltip_text = "%d yr %d mo before retirement!" % [years_left, months_left]

func _on_GameTimer_timeout() -> void:
	current_month += 1
	if current_month == months.size():
		current_month = 0
		current_year += 1
	if current_year == 100:
		current_year = 0
	refresh_date()
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

