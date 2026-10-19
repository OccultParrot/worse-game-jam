extends Node2D

signal cauldron_view_requested
signal paper_view_requested

@export var recipe: RecipeData

@onready var cauldron_mask = load("res://assets/textures/mainviewmask.png")
@onready var ink_shader = load("res://assets/shaders/ink.gdshader")
@onready var outline_shader = load("res://assets/shaders/outline.gdshader")

var wand := preload("res://scenes/wand.tscn")

var ink_material: ShaderMaterial
var outline_material: ShaderMaterial

@onready var water = $CauldronWater
@onready var cauldron_outline = $CauldronOutline
@onready var paper_outline = $PaperOutline

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.recipe = recipe
	GameState.recipe_progress = RecipeData.new(Color.WHITE, 0.0)
	
	ink_material = ShaderMaterial.new()
	ink_material.shader = ink_shader
	_update_ink()
	
	outline_material = ShaderMaterial.new()
	outline_material.shader = outline_shader
	
	var instanced_wand = wand.instantiate()
	add_child(instanced_wand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_ink():
	if not is_node_ready():
		return

	if GameState.recipe_progress.color == Color.WHITE:
		ink_material.set_shader_parameter("ink_color", Color.CADET_BLUE)
		
	else:
		ink_material.set_shader_parameter("ink_color", GameState.recipe_progress.color)
	water.material = ink_material


func _on_caudron_mouth_ink_changed():
	_update_ink()


func _on_cauldron_mouse_detect_mouse_entered():
	cauldron_outline.material = outline_material


func _on_cauldron_mouse_detect_mouse_exited():
	cauldron_outline.material = null


func _on_paper_mouse_detect_mouse_entered():
	paper_outline.material = outline_material


func _on_paper_mouse_detect_mouse_exited():
	paper_outline.material = null


func _on_paper_mouse_detect_paper_mouse_click():
	paper_view_requested.emit()


func _on_cauldron_mouse_detect_cauldron_mouse_click():
	cauldron_view_requested.emit()
