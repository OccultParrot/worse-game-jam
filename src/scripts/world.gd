extends Node2D

const MAIN_MENU := preload("res://scenes/main_menu.tscn")
const MAIN_VIEW := preload("res://scenes/MainView.tscn")
const CAULDRON_VIEW := preload("res://scenes/caldron_screen.tscn")
const PAPER_VIEW := preload("res://scenes/paper_view.tscn")

var current_view: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	show_view(MAIN_MENU)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_view(view_scene: PackedScene) -> void:
	if current_view:
		current_view.queue_free()
	current_view = view_scene.instantiate()
	add_child(current_view)
	if current_view.has_signal("main_view_requested"):
		current_view.main_view_requested.connect(show_view.bind(MAIN_VIEW))
	if current_view.has_signal("cauldron_view_requested"):
		current_view.cauldron_view_requested.connect(show_view.bind(CAULDRON_VIEW))
	if current_view.has_signal("paper_view_requested"):
		current_view.paper_view_requested.connect(show_view.bind(PAPER_VIEW))
