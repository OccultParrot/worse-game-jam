extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_view(view_name: String):
	for scene in get_children():
		if scene is not Node2D:
			continue
		scene = scene as Node2D
		scene.visible = scene.name == view_name
