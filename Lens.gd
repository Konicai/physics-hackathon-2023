extends Area2D

var vertices: Array = [Vector2(0, 0), Vector2(0, 10), Vector2(10, 10), Vector2(10, 0)]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	for i in range(1, vertices.size()):
		print(i)
	
		var a = vertices[i - 1]
		var b = vertices[i] 
		add_linear_segment_collision(a, b)
		
	# link the last one
	add_linear_segment_collision(vertices[vertices.size() - 1], vertices[0])
		
		
		
func add_linear_segment_collision(a: Vector2, b: Vector2):
	var segment: SegmentShape2D = SegmentShape2D.new()
	segment.a = a
	segment.b = b
	segment.resource_name = "segment" + toString(a) + toString(b)
	
	var collision: CollisionShape2D = CollisionShape2D.new()
	collision.shape = segment
	
	add_child(collision)
	print("added " + segment.resource_name)
	
func toString(v: Vector2) -> String:
	return "(" + str(v.x) + "," + str(v.y) + ")"
		
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
