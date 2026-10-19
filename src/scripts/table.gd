extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in get_overlapping_bodies():
		if body is not InteractiveNode:
			return
		body = body as InteractiveNode
		if !body.is_on_table:
			body.is_on_table = true



func _on_body_exited(body):
	if body is not InteractiveNode:
		return
	if body.is_on_table:
		body.is_on_table = false


func _on_body_entered(body):
	if body is not InteractiveNode:
		return
		
	body.linear_velocity = Vector2.ZERO
