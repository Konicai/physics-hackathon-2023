extends RigidBody2D


var rotate_speed: float = PI

var mouse_hovering: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# required for checking mouse hovering
	input_pickable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# rotate logic
	var clockwise = Input.is_action_pressed("rotate_clockwise")
	var counter = Input.is_action_pressed("rotate_counter_clockwise")
	if mouse_hovering and (clockwise or counter):
		var speed = rotate_speed
		if counter:
			speed *= -1
		
		rotate(speed * delta)
		
	# drag logic



func _on_mouse_entered():
	mouse_hovering = true
	
func _on_mouse_exited():
	mouse_hovering = false


func _on_input(event):
	print("fuck")
	pass


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not event.pressed:
				print("you let go")
