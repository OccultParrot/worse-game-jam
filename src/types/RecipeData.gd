extends Resource
class_name RecipeData

@export var color: Color = Color.WHITE
@export var cook_time: float = 0.0
@export var correctness_threshold: float = 0.0

func _init(color: Color, cook_time: float, threshold: float = 0.0) -> void:
	self.color = color
	self.cook_time = cook_time
	self.correctness_threshold = threshold
