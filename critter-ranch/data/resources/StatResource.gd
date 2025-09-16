extends Resource
class_name StatResource

@export var stat_name: String = "Unnamed"
@export var current_value: float = 50.0
@export var max_value: float = 100.0
@export var min_value: float = 0.0
@export var decay_rate: float = 10.0  # Per day without care
@export var icon: Texture2D

func duplicate_stat() -> Resource:  # Changed from StatResource to Resource
	var new_stat = StatResource.new()
	new_stat.stat_name = stat_name
	new_stat.current_value = current_value
	new_stat.max_value = max_value
	new_stat.min_value = min_value
	new_stat.decay_rate = decay_rate
	new_stat.icon = icon
	return new_stat
