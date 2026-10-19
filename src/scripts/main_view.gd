extends Node2D

@export var recipe: RecipeData

@onready var cauldron_mask = load("res://assets/textures/mainviewmask.png")
@onready var ink_shader = load("res://assets/shaders/ink.gdshader")

var ink_material: ShaderMaterial
var has_ink_changed: bool = false

@onready var water = $CauldronWater

# Called when the node enters the scene tree for the first time.
func _ready():
	ink_material = ShaderMaterial.new()
	ink_material.shader = ink_shader
	_update_ink()

	GameState.recipe = recipe


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_ink():
	if not is_node_ready():
		return

	if has_ink_changed:
		ink_material.set_shader_parameter("ink_color", GameState.recipe_progress.color)
	else:
		ink_material.set_shader_parameter("ink_color", Color.CADET_BLUE)
	water.material = ink_material


func _on_caudron_mouth_ink_changed():
	if !has_ink_changed:
		has_ink_changed = true
		
	_update_ink()
