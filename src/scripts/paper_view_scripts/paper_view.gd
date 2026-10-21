extends WorldView

var instanced_pen: Node2D
var pen_offset = Vector2(35.0, -80.0)
var pen := preload("res://scenes/Hands/pen_hand.tscn")
var paper_buffer: Image

var stroke_array: ObservableArray = ObservableArray.new()
var image: Image

var last_point: Vector2i
var has_last_point := false

@export var width := 150
@export var height := 150

@export var display_width := 600
@export var display_height := 600

@onready var canvas: Sprite2D = $Canvas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instanced_pen = pen.instantiate()
	instanced_pen.position = get_global_mouse_position()
	add_child(instanced_pen)
	for y in range(height):
		for x in range(width):
			stroke_array.append(false)
	
	# Stretch the small texture back to the display size, with hard pixel edges
	canvas.scale = Vector2(float(display_width) / width, float(display_height) / height)
	canvas.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	_update_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = canvas.to_local(instanced_pen.position - pen_offset)
	var in_bounds: bool = mouse_pos.x >= 0 and mouse_pos.y >= 0 \
		and mouse_pos.x < width and mouse_pos.y < height
	
	if not (in_bounds and Input.is_action_pressed("pick-up")):
		has_last_point = false
		return
	
	var current := Vector2i(mouse_pos.floor())
	if has_last_point and current == last_point:
		return
	
	var from := last_point if has_last_point else current
	var index_array: Array[int] = []
	for p in _line_pixels(from, current):
		image.set_pixel(p.x, p.y, GameState.recipe_progress.color)
		index_array.append(p.y * width + p.x)
	
	(canvas.texture as ImageTexture).update(image)
	stroke_array.batch_set(index_array, true)
	last_point = current
	has_last_point = true


func _update_texture():
	var byte_array := PackedByteArray()
	# Three values per pixel. RGB
	byte_array.resize(stroke_array.size() * 4)
	for i in range(stroke_array.size()):
		var value := 255 if (stroke_array.get_item(i) as bool) else 0
		var base_idx = i * 4
		byte_array[base_idx + 0] = GameState.recipe_progress.color.r # Red
		byte_array[base_idx + 1] = GameState.recipe_progress.color.g # Green
		byte_array[base_idx + 2] = GameState.recipe_progress.color.b # Bluea
		byte_array[base_idx + 3] = 0.0
	image = Image.create_from_data(width, height, false, Image.FORMAT_RGBA8, byte_array)
	canvas.texture = ImageTexture.create_from_image(image)


func _line_pixels(from: Vector2i, to: Vector2i) -> Array[Vector2i]:
	var pixels: Array[Vector2i] = []
	var steps := maxi(absi(to.x - from.x), absi(to.y - from.y))
	for s in range(steps + 1):
		var t := float(s) / steps if steps > 0 else 0.0
		pixels.append(Vector2i(Vector2(from).lerp(Vector2(to), t).round()))
	return pixels
