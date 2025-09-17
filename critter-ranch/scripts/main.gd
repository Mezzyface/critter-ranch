# Game.gd
extends Node2D

@export var egg_scene: PackedScene = preload("res://scenes/creatures/egg.tscn")
@export var baby_scene: PackedScene = preload("res://scenes/creatures/baby.tscn")

@export var evolved_scene: PackedScene  # For evolution example

@onready var spawn_position = $SpawnPosition
@onready var hatch_manager = $HatchManager
@onready var evolution_manager = $EvolutionManager
@onready var evo_label: Label = $UI/EvoLabel

var current_egg: Node2D
var current_creature: Node2D

func _ready():
	# Connect to manager signals
	hatch_manager.transition_completed.connect(_on_hatch_completed)
	evolution_manager.transition_completed.connect(_on_evolution_completed)
	
	spawn_egg()

func spawn_egg():
	current_egg = egg_scene.instantiate()
	add_child(current_egg)
	current_egg.position = spawn_position.position
	
	# Setup hatching
	hatch_manager.setup_for_animation_end(current_egg, baby_scene)
	
	# Or use specific frame:
	# hatch_manager.setup_for_specific_frame(current_egg, baby_scene, 5)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if current_egg and not hatch_manager.is_transitioning:
			hatch_manager.start_hatching()

	if event.is_action_pressed("ui_select") and current_creature:  # Enter key
		current_creature.increment_evo()
		update_display()
			
	# Press E to evolve
	if event.is_action_pressed("evolve") and current_creature:
		try_evolution()

	if event.is_action_pressed("reset_game"):
		get_tree().reload_current_scene()

func try_evolution():
	if not current_creature or evolution_manager.is_transitioning:
		return

	var next_evolution = current_creature.get_next_evolution()
	if next_evolution:
		evolution_manager.start_evolution(current_creature, next_evolution)
	else:
		print("No evolution available!")

func _on_hatch_completed():
	current_egg = null
	current_creature = hatch_manager.spawned_node
	update_display()

func _on_evolution_completed():
	var old_evo_stat = current_creature.evo_stat  # Keep the stat
	current_creature = evolution_manager.spawned_node as Creature
	if current_creature:
		current_creature.evo_stat = old_evo_stat  # Transfer stat
	update_display()

func update_display():
	if current_creature:
		evo_label.text = "Evo: %d" % current_creature.evo_stat
	else:
		evo_label.text = "No creature"
