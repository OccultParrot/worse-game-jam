extends Node2D

@export_range(0.0, 1.0) var smoothing_weight: float = 0.05

@onready var area: Area2D = $Area2D
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
		
	## Check Pick Up
	if !held_node and Input.is_action_pressed("pick-up") and area.has_overlapping_bodies():
		var selected_node: InteractiveNode
		for node in area.get_overlapping_bodies():
			if node is InteractiveNode:
				selected_node = node
				selected_node.is_held = true
				print("Picking Up ", selected_node.name)
				held_node = selected_node
				
				selected_node.linear_velocity = Vector2(0.0, 200.0)
				break
	## Move
	position = lerp(position, get_global_mouse_position(), smoothing_weight)
	## Move Held Node
	if held_node:
		held_node.target_position = global_position
	
