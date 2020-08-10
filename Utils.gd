## Utility functions
## Autoloaded
extends Node

func usd_to_str(amount: float) -> String:
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
	return "31337"

func create_map(w: int, h: int) -> Array:
	var map = []
	for x in range(w):
		var col = []
		col.resize(h)
		map.append(col)
	return map
