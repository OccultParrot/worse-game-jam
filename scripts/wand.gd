extends Node2D

@export_range(0.0, 1.0) var smoothing_weight: float = 0.05

@onready var area: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D
var held_node: InteractiveNode
var held_offset: Vector2

var hand_closed: Resource
var hand_opened: Resource


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand_closed = load("res://assets/ClosedHand.png")
	hand_opened = load("res://assets/OpenHand.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pick-up") and sprite.texture != hand_closed:
		sprite.texture = hand_closed
	elif Input.is_action_just_released("pick-up") and sprite.texture != hand_opened:
		sprite.texture = hand_opened
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
				held_node = selected_node
				held_offset = held_node.position - global_position
				
				print("Picking Up ", selected_node.name)
				break
	## Move
	position = lerp(position, get_global_mouse_position(), smoothing_weight)
	
	## Move Held Node
	if held_node:
		held_node.target_position = global_position + held_offset
	
