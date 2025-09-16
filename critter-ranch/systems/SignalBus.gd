extends Node

# Day signals (no more time slots!)
signal day_started(day: int)
signal day_advanced(day: int)

# Activity signals
signal activity_started(creature: Node, activity: int)
signal activity_completed(creature: Node, activity: int)

# Economy signals
signal money_changed(amount: int, total: int)
signal transaction_failed(reason: String)

# Creature signals
signal creature_aged(creature_id: String, new_age: int)
signal creature_evolved(creature_id: String, new_stage: String)
signal creature_stat_changed(creature_id: String, stat_name: String, new_value: float)

# Request signals
signal request_completed(request: Resource, creature: Node)
signal request_failed(request: Resource, reason: String)
signal new_request_available(request: Resource)

# UI signals
signal ui_creature_selected(creature: Node)
signal ui_request_selected(request: Resource)

func _ready():
	print("SignalBus initialized")
