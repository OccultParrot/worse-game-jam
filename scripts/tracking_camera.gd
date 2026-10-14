extends Camera2D

@export var tracked_node: Node2D
@export var smoothing_weight: float = 0.05

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tracked_node == null:
		return
	
	position = lerp(position, tracked_node.position, smoothing_weight)
