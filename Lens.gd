extends Area2D

var vertices: PackedVector2Array = [Vector2(0, 0), Vector2(0, 50), Vector2(200, 50), Vector2(200, 0)]
var outline_width: int = 10 # default

var photon_scene: PackedScene = preload("res://photon.tscn")

# dragging and rotating
var rotate_speed: float = PI
var mouse_hovering: bool = false
var dragging: bool = false

# physics
var expected_photons: Dictionary = {} 

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
	collision.name = "segmentcollision" + toString(a) + toString(b)
	add_child(collision)
	

func toString(v: Vector2) -> String:
	return "(" + str(v.x) + "," + str(v.y) + ")"
	
func toStringPolar(v: Vector2) -> String:
	return "(" + str(v.angle() * 180 / PI) + " degrees, " + str(v.length()) + " long)"


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

# used for overall entering
func _on_body_entered(body: Node2D):
	if "ball" in body.name.to_lower():
		print("entered lens")
		expected_photons[body] = true

# used for overall exiting
func _on_body_exited(body: Node2D):
	if "ball" in body.name.to_lower():
		print("exiting lens")
		expected_photons.erase(body)
		
func toDegrees(rads: float) -> float:
	return rads * 180 / PI
		

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):

	var collision = get_child(local_shape_index)
	if not ("Ball" in body.name and "segmentcollision" in collision.name):
		return
		
	print("hit collider: " + collision.name)
	var shape: SegmentShape2D = collision.get_shape()

	
	var interface_vec: Vector2 = shape.a - shape.b
	
	# shape coordinations don't take rotation into account
	interface_vec = interface_vec.rotated(rotation)
	
	var ray_velocity: Vector2 = body.linear_velocity

	var angle = interface_vec.angle_to(ray_velocity)
	
	angle = abs(angle)
	if angle > PI / 4:
		angle = PI / 2 - angle
	
		

	print("a: " + toString(shape.a))
	print("b: " + toString(shape.b))
	print("ray velocity: " + toStringPolar(ray_velocity))
	print("interface vec: " + toStringPolar(interface_vec)) 
	print("angle: " + str(toDegrees(angle)))
	
	var n1: float
	var n2: float
	if body in expected_photons:
		print("entering")
		# entering
		n1 = 1
		n2 = 1.5
		expected_photons.erase(body)
	else:
		print("exiting")
		n1 = 1.5
		n2 = 1
		
	var angle_1 = angle
	
	# n1sin1  =n2sin2
	#n1/n2 * sin1 = sin2
	
	var angle_2 = asin((n1 / n2) * sin(angle_1))
	
	var angle_diff = angle_2 - angle_1
	
	body.linear_velocity = body.linear_velocity.rotated(angle_diff)


