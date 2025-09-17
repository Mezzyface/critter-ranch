# Creature.gd
extends Node2D
class_name Creature

@export var creature_name: String = ""
@export var evo_stat: int = 0

# Evolution thresholds - creature evolves based on evo_stat value
@export var evolution_low: PackedScene    # evo_stat 0-4
@export var evolution_medium: PackedScene # evo_stat 5-9  
@export var evolution_high: PackedScene   # evo_stat 10+

func increment_evo():
	evo_stat += 1
	print("Evo stat: ", evo_stat)

func get_next_evolution() -> PackedScene:
	if evo_stat >= 10 and evolution_high:
		return evolution_high
	elif evo_stat >= 5 and evolution_medium:
		return evolution_medium
	elif evolution_low:
		return evolution_low
	
	return null
