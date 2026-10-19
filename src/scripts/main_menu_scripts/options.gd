extends Button

@export var lable_text: String = "Options"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_hovered():
		$RichTextLabel.text = "[shake rate=20.0 level=5 connected=1]%s[/shake]" % lable_text
	else:
		$RichTextLabel.text = lable_text
