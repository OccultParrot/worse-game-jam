extends RigidBody2D
class_name InteractiveNode

var is_held: bool = false
@export var is_on_table: bool = false
@onready var target_position = position
@export_range(0.0, 10.0) var linear_damp_set_point = 5.0
@export_range(0.0, 10.0) var angular_damp_set_point = 5.0
@export var object_mass: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_damp = linear_damp_set_point
	angular_damp = angular_damp_set_point
	mass = object_mass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lock_rotation = is_held
	angular_damp = 5

func _physics_process(delta: float) -> void:
	if is_held:
		gravity_scale = 0.0
		linear_damp = 0
	
	if !is_on_table:
		linear_damp = 0.0
		gravity_scale = 1.0
	elif is_on_table:
		linear_damp = linear_damp_set_point
		gravity_scale = 0.0
		

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if is_held:
		state.linear_velocity = (target_position - state.transform.origin) / state.step
