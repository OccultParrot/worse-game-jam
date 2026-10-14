extends RigidBody2D
class_name InteractiveNode

var is_held: bool = false
@onready var target_position = position
@export var linear_damp_set_point = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_damp = linear_damp_set_point


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lock_rotation = is_held
	angular_damp = 5

func _physics_process(delta: float) -> void:
	if is_held:
		linear_damp = 0
	elif linear_damp == 0:
		linear_damp = linear_damp_set_point

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if is_held:
		state.linear_velocity = (target_position - state.transform.origin) / state.step
