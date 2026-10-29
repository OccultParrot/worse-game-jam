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
		GameState.ingredients_in_pot.append(body.ingredient_id)
		print(GameState.ingredients_in_pot)
		
		body.queue_free()
