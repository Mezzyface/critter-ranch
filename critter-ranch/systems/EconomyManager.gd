extends Node

var current_money: int = 0

func _ready():
	current_money = GameConstants.STARTING_MONEY
	print("EconomyManager initialized with %d gold" % current_money)
	# Listen for day changes to deduct daily costs
	SignalBus.day_advanced.connect(_on_day_advanced)
	
func get_money() -> int:
	return current_money
	
func can_afford(amount: int) -> bool:
	return current_money >= amount
	
func spend(amount: int, reason: String = "") -> bool:
	if not can_afford(amount):
		SignalBus.transaction_failed.emit("Not enough money: need %d, have %d" % [amount, current_money])
		return false
		
	current_money -= amount
	SignalBus.money_changed.emit(-amount, current_money)
	print("Spent %d gold on %s. Remaining: %d" % [amount, reason, current_money])
	return true
	
func earn(amount: int, source: String = ""):
	current_money += amount
	SignalBus.money_changed.emit(amount, current_money)
	print("Earned %d gold from %s. Total: %d" % [amount, source, current_money])

func _on_day_advanced(day: int):
	# This will deduct daily creature upkeep costs
	print("Processing daily costs for day %d" % day)
	# TODO: Add creature upkeep deduction here
