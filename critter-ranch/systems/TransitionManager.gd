# TransitionManager.gd
extends Node

class_name TransitionManager

signal transition_started
signal transition_completed

@export var transition_duration: float = 0.3
@export var scale_in_duration: float = 0.3

var is_transitioning: bool = false
var source_node: Node2D
var target_scene: PackedScene
var spawned_node: Node2D

func start_transition(source: Node2D, target: PackedScene) -> void:
	if is_transitioning:
		return
	
	is_transitioning = true
	source_node = source
	target_scene = target
	transition_started.emit()
	
	_perform_transition()

func _perform_transition() -> void:
	# Override in child classes
	pass

func _spawn_target() -> Node2D:
	if not target_scene:
		push_error("No target scene set!")
		return null
		
	spawned_node = target_scene.instantiate()
	source_node.get_parent().add_child(spawned_node)
	spawned_node.position = source_node.position
	spawned_node.scale = Vector2(0.1, 0.1)
	
	return spawned_node

func _cleanup() -> void:
	if source_node:
		source_node.queue_free()
	is_transitioning = false
	transition_completed.emit()
