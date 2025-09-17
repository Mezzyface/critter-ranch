# HatchManager.gd
extends TransitionManager

class_name HatchManager

@export var particle_amount: int = 20
@export var particle_colors: Array[Color] = [Color.WHITE]

var egg_sprite: AnimatedSprite2D
var spawn_at_completion: bool = true

func setup_for_animation_end(egg: Node2D, baby_scene: PackedScene) -> void:
	source_node = egg
	target_scene = baby_scene
	egg_sprite = egg.get_node("AnimatedSprite2D")
	
	# Connect to animation finished
	egg_sprite.animation_finished.connect(_on_hatch_animation_finished)

func setup_for_specific_frame(egg: Node2D, baby_scene: PackedScene, frame: int) -> void:
	source_node = egg
	target_scene = baby_scene
	egg_sprite = egg.get_node("AnimatedSprite2D")
	spawn_at_completion = false
	
	# Watch for specific frame
	egg_sprite.frame_changed.connect(_on_frame_changed.bind(frame))
	egg_sprite.animation_finished.connect(_on_hatch_animation_finished)

func start_hatching(animation_name: String = "hatch") -> void:
	if is_transitioning:
		return
	
	is_transitioning = true
	egg_sprite.play(animation_name)
	transition_started.emit()

func _on_frame_changed(target_frame: int) -> void:
	if egg_sprite.frame >= target_frame and not spawned_node:
		_spawn_baby()
		egg_sprite.frame_changed.disconnect(_on_frame_changed)

func _on_hatch_animation_finished() -> void:
	if spawn_at_completion and not spawned_node:
		_spawn_baby()
	
	await get_tree().create_timer(0.1).timeout
	_cleanup()

func _spawn_baby() -> void:
	spawned_node = _spawn_target()
	if not spawned_node:
		return
	
	# Create particles
	_create_hatch_particles()
	
	# Scale up animation
	var tween = create_tween()
	tween.tween_property(spawned_node, "scale", Vector2(1.0, 1.0), scale_in_duration).set_trans(Tween.TRANS_BACK)
	
	# Start idle animation if available
	if spawned_node.has_node("AnimatedSprite2D"):
		var sprite = spawned_node.get_node("AnimatedSprite2D")
		sprite.play("idle")

func _create_hatch_particles() -> void:
	var particles = CPUParticles2D.new()
	source_node.get_parent().add_child(particles)
	particles.position = source_node.position
	particles.emitting = true
	particles.amount = particle_amount
	particles.lifetime = 0.5
	particles.one_shot = true
	particles.initial_velocity_min = 50.0
	particles.initial_velocity_max = 150.0
	particles.direction = Vector2(0, -1)
	particles.spread = 45.0
	particles.gravity = Vector2(0, 500)
	
	if particle_colors.size() > 0:
		particles.color = particle_colors[0]
	
	particles.finished.connect(func(): particles.queue_free())
