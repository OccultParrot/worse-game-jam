extends Area2D

signal ink_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in get_overlapping_bodies():
		if body is not IngredientNode:
			continue
		body = body as IngredientNode
		if body.is_held:
			continue
		
		GameState.recipe_progress.color *= body.color
		print(GameState.recipe_progress.color.to_html(true))
		
		body.queue_free()
		ink_changed.emit()
