extends WorldView

var wand := preload("res://scenes/wand.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instanced_wand = wand.instantiate()
	add_child(instanced_wand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
