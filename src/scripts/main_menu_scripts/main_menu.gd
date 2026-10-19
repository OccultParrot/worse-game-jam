extends Control

signal main_view_requested
signal options_view_requested
signal exit_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	main_view_requested.emit()


func _on_options_pressed() -> void:
	options_view_requested.emit()


func _on_exit_pressed() -> void:
	$VBoxContainer/Exit.queue_free()
