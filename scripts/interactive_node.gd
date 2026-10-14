@icon("res://icon.svg")
extends Node2D
class_name InteractiveNode

var is_held: bool
@onready var last_position: Vector2 = position
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_held:
		velocity = position - last_position
		return
	
	
