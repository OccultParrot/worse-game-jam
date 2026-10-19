extends WorldView

var pen := preload("res://scenes/pen_hand.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instanced_pen = pen.instantiate()
	instanced_pen.position = get_global_mouse_position()
	add_child(instanced_pen)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
