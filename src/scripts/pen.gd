extends InteractiveNode

@export var is_full: bool = false:
	set(value):
		is_full = value
		_update_ink()
@export var ink_color: Color = Color.BLACK:
	set(value):
		ink_color = value
		_update_ink()

@onready var ink_mask = load("res://assets/textures/PenMask.png")
@onready var ink_shader = load("res://assets/shaders/pen_ink.gdshader")
@onready var sprite = $Sprite2D

var ink_material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	ink_material = ShaderMaterial.new()
	ink_material.shader = ink_shader
	_update_ink()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	# TODO: Remove. For testing
	if Input.is_action_just_pressed("up"):
		is_full = !is_full

func _update_ink():
	if not is_node_ready():
		return
	
	if is_full:
		ink_material.set_shader_parameter("ink_mask", ink_mask)
		ink_material.set_shader_parameter("ink_color", ink_color)
		sprite.material = ink_material
	else:
		sprite.material = null
