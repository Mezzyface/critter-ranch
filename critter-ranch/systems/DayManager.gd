extends Node

var current_day: int = 1
var activities_today: Dictionary = {}  # creature_id: activity

func _ready():
	print("DayManager initialized - Day %d" % current_day)
	SignalBus.day_started.emit(current_day)

func record_activity(creature_id: String, activity: int):
	activities_today[creature_id] = activity
	print("Recorded: Creature %s will perform activity %d today" % [creature_id, activity])

func advance_day():
	# Process all activities for the day
	for creature_id in activities_today:
		var activity = activities_today[creature_id]
		print("Processing activity %d for creature %s" % [activity, creature_id])
		# Activities will be processed by creature manager
	
	# Clear activities and advance
	activities_today.clear()
	current_day += 1
	SignalBus.day_advanced.emit(current_day)
	SignalBus.day_started.emit(current_day)
	print("Advanced to Day %d" % current_day)

func can_advance() -> bool:
	# Optional: Require all creatures to have activities assigned
	return true
