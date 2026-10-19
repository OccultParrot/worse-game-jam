extends InteractiveNode
class_name IngredientNode

@export var ingredient_id: GlobalEnums.IngredientIDs
@export var color: Color = Color.BLACK

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
