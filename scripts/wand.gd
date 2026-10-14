extends Node2D

@export var smoothing_weight: float = 0.05

@onready var area = $Area2D
var held_node: InteractiveNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check Dropped
	if held_node and !Input.is_action_pressed("pick-up"):
		held_node.is_held = false
		held_node = null # Drop the Node
	# Check Pick Up
	if !held_node and Input.is_action_pressed("pick-up") and area.has_overlapping_areas():
		var selected_node: InteractiveNode
		for node in area.get_overlapping_areas():
			if node.get_parent() is InteractiveNode:
				selected_node = node.get_parent()
				selected_node.is_held = true
		print("Picking Up ", selected_node.name)
		held_node = selected_node
		
	
	# Move
	position = lerp(position, get_global_mouse_position(), smoothing_weight)
	# Move Held Node
	if held_node:
		held_node.position = position
	
	
	
