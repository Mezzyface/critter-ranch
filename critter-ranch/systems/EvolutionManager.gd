# EvolutionManager.gd
extends TransitionManager

class_name EvolutionManager

@export var glow_color: Color = Color(1, 1, 0.5, 0.8)
@export var evolution_particles: bool = true
@export var spin_during_evolution: bool = true
@export var poof_scene: PackedScene  # NEW: Drag your poof scene here!

func start_evolution(creature: Node2D, evolved_form: PackedScene) -> void:
	start_transition(creature, evolved_form)

func _perform_transition() -> void:
	# Create glow effect
	_add_glow_effect()
	
	var original_position = source_node.position
	
	# Start evolution animation
	if spin_during_evolution:
		_start_spin_animation()

	var shrink_tween = create_tween()
	shrink_tween.set_parallel(true)

	# Shrink the creature
	shrink_tween.tween_property(source_node, "scale", Vector2(0.3, 0.3), transition_duration)

	# Rise up (negative Y is up in Godot)
	shrink_tween.tween_property(source_node, "position", 
		original_position + Vector2(0, -30), transition_duration).set_ease(Tween.EASE_OUT)

	# Spawn poof animation
	_spawn_poof()

	# Wait for effect
	await get_tree().create_timer(transition_duration).timeout
		
	# Hide original creature during poof
	source_node.visible = false

	# Wait a moment for poof to start
	await get_tree().create_timer(0.1).timeout
	
	# Spawn evolved form
	_spawn_evolved_creature_at_position(original_position)
	
	# Cleanup after short delay
	await get_tree().create_timer(0.2).timeout
	_cleanup()

func _spawn_poof() -> void:
	if not poof_scene:
		push_warning("No poof scene assigned to EvolutionManager!")
		return
		
	var poof = poof_scene.instantiate()
	source_node.get_parent().add_child(poof)
	poof.position = source_node.position
	
	# Get the AnimatedSprite2D from poof
	var poof_sprite = poof.get_node("AnimatedSprite2D")
	poof.z_index = 10  
	
	poof_sprite.sprite_frames.set_animation_loop("default", false) 
	
	# Play the animation
	poof_sprite.play("default")  # or whatever your animation is called
	
	# Clean up poof when animation finishes
	poof_sprite.animation_finished.connect(func(): poof.queue_free())

func _add_glow_effect() -> void:
	source_node.modulate = glow_color
	
	# Create glow particles
	if evolution_particles:
		var particles = CPUParticles2D.new()
		source_node.get_parent().add_child(particles)
		particles.position = source_node.position
		particles.emitting = true
		particles.amount = 50
		particles.lifetime = 1.0
		particles.initial_velocity_min = 0
		particles.initial_velocity_max = 0
		particles.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
		particles.emission_sphere_radius = 30.0
		particles.scale_amount_min = 2.0
		particles.scale_amount_max = 4.0
		particles.color = glow_color
		
		await get_tree().create_timer(transition_duration + 0.5).timeout
		particles.queue_free()

func _start_spin_animation() -> void:
	var tween = create_tween()
	tween.set_loops(int(transition_duration * 4))  # 4 spins per second
	tween.tween_property(source_node, "rotation", source_node.rotation + TAU, 0.25)

func _spawn_evolved_creature() -> void:
	spawned_node = _spawn_target()
	if not spawned_node:
		return
	
	# Flash effect
	spawned_node.modulate = Color(2, 2, 2, 1)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(spawned_node, "scale", Vector2(1.2, 1.2), 0.2).set_trans(Tween.TRANS_BACK)
	tween.chain().tween_property(spawned_node, "scale", Vector2(1.0, 1.0), 0.1)
	tween.tween_property(spawned_node, "modulate", Color.WHITE, 0.3)
	
	# Start animation if available
	if spawned_node.has_node("AnimatedSprite2D"):
		var sprite = spawned_node.get_node("AnimatedSprite2D")
		if sprite.sprite_frames.has_animation("appear"):
			sprite.play("appear")
		else:
			sprite.play("idle")
			
func _spawn_evolved_creature_at_position(spawn_position: Vector2) -> void:
	spawned_node = _spawn_target()
	if not spawned_node:
		return

	# Override position to be at the original ground level
	spawned_node.position = spawn_position

	# Start invisible and scale up from small
	spawned_node.modulate = Color(1, 1, 1, 0)
	spawned_node.scale = Vector2(0.5, 0.5)

	var tween = create_tween()
	tween.set_parallel(true)
	# Fade in
	tween.tween_property(spawned_node, "modulate:a", 1.0, 0.3)
	# Scale up
	tween.tween_property(spawned_node, "scale", Vector2(1.0, 1.0), 0.3).set_trans(Tween.TRANS_BACK)

	# Start animation if available
	if spawned_node.has_node("AnimatedSprite2D"):
		var sprite = spawned_node.get_node("AnimatedSprite2D")
		if sprite.sprite_frames.has_animation("appear"):
			sprite.play("appear")
		else:
			sprite.play("idle")
