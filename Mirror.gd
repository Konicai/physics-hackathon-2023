extends RigidBody2D


var rotate_speed: float = PI
var mouse_hovering: bool = false
var dragging: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	# required for checking mouse hovering
	input_pickable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
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

