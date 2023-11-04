extends Node2D

var ball_scene = preload("res://Laser assets/ball.tscn")
var launch_speed = Vector2(0, -500)
var ball_to_launch = null
var ball_fired = false
var last_ball_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	$StaticBody2D.position = screen_size / 2
	# Assuming 'Line2D' is already a node in the scene
	$Line2D.width = 2
	$Line2D.default_color = Color(1, 0, 0)  # Set line color to red
func _process(delta):
	if Input.is_action_just_pressed("fire"):
		fire_ball()
	if $Line2D.get_point_count() > 0:
		$Line2D.set_point_position($Line2D.get_point_count() - 1, $Ball.position)
	if ball_to_launch and ball_to_launch.position != last_ball_position:
		# Call the function that updates the line with the new position
		_on_Ball_position_changed(ball_to_launch.position)
		# Update the last position to the current one
		last_ball_position = ball_to_launch.position
func _physics_process(delta):
	if ball_to_launch and not ball_fired:
		ball_to_launch.apply_impulse(launch_speed)
		ball_fired = true
		# Clear previous points when a new ball is launched
		$Line2D.points.clear()

func fire_ball():
	var ball_instance = ball_scene.instantiate()
	ball_instance.sleeping = false
	ball_instance.position = $StaticBody2D.global_position + Vector2(0, -100)
	add_child(ball_instance)
	ball_to_launch = ball_instance
	last_ball_position = ball_to_launch.position
	# Connect 'position_changed' signal to the method to update the line
	# ball_instance.connect("position_changed", Callable(self, "_on_Ball_position_changed"))

# This method will be called when the 'position_changed' signal is emitted
func _on_Ball_position_changed(new_position):
	# Add the new position of the ball to the Line2D points
	$Line2D.add_point(new_position)
