extends Area2D

var vertices: PackedVector2Array = [Vector2(0, 0), Vector2(0, 50), Vector2(200, 50), Vector2(200, 0)]
var outline_width: int = 10 # default

var photon_scene: PackedScene = preload("res://Photon.tscn")

# dragging and rotating
var rotate_speed: float = PI
var mouse_hovering: bool = false
var dragging: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	input_pickable = true
	
	var screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	
	for i in range(1, vertices.size()):
		var a = vertices[i - 1]
		var b = vertices[i] 
		add_linear_segment_collision(a, b)
		$outline.add_point(a)
		
	# link the last one
	add_linear_segment_collision(vertices[vertices.size() - 1], vertices[0])
	$outline.add_point(vertices[vertices.size() - 1])
	$outline.add_point(vertices[0])
	
	# hack to make it look nicer - less chunky at the first point
	$outline.add_point(vertices[1])
	
	# display the outline
	$outline.width = outline_width
	
	# the fill shape
	$fill_shape.polygon = vertices
		
func add_linear_segment_collision(a: Vector2, b: Vector2):
	var segment: SegmentShape2D = SegmentShape2D.new()
	segment.a = a
	segment.b = b
	segment.resource_name = "segment" + toString(a) + toString(b)
	
	var collision: CollisionShape2D = CollisionShape2D.new()
	collision.shape = segment
	add_child(collision)
	

func toString(v: Vector2) -> String:
	return "(" + str(v.x) + "," + str(v.y) + ")"


func _process(delta):

	if Input.is_action_pressed("rotate_clockwise") or Input.is_action_pressed("rotate_counter_clockwise"):

		if mouse_hovering:
			var speed = rotate_speed
			if Input.is_action_pressed("rotate_counter_clockwise"):
				speed *= -1

			rotate(speed * delta)

	if dragging:
		global_position = get_global_mouse_position()


func _on_mouse_entered():
	mouse_hovering = true

func _on_mouse_exited():
	mouse_hovering = false

func _on_input_event(viewport, event: InputEvent, shape_idx):
	if event.is_action_pressed("click"):
		dragging = true
	if event.is_action_released("click"):
		dragging = false


func _on_body_entered(body: Node2D):
	if "ball" in body.name.to_lower():
		print("dookey")
		

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print()
	print("body rid: " + str(body_rid))
	print("body: " + str(body))
	print("body shape index: " + str(body_shape_index))
	print("local shape index: " + str(local_shape_index))
