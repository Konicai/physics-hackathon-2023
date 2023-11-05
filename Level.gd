extends Node2D

var ball_scene = preload("res://Photon.tscn")
var launch_speed = Vector2(-1500, 0)
var ball_to_launch = null
var ball_fired = false
var last_ball_position = Vector2()

var mirror_scene = preload("res://Mirror.tscn")
var planet = preload("res://Grav.tscn")
var receptor_scene = preload("res://Receptor.tscn")

var planett = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var screen_size = get_viewport_rect().size
	var receptor = receptor_scene.instantiate()
	receptor.position = Vector2(50,50)
	receptor.rotate(180)
	add_child(receptor)
	# mirror
	var mirror1 = mirror_scene.instantiate()
	mirror1.position = Vector2(screen_size.x / 2, screen_size.y / 2)
	mirror1.rotate(PI / 4)
	add_child(mirror1)
	
	planett = planet.instantiate()
	planett.position = Vector2(screen_size.x - 200, screen_size.y-250)
	add_child(planett)
	
	$laser.position = Vector2(screen_size.x - 100, screen_size.y - 100)
	$laser.rotate(-PI/2)
	$topWall.position = Vector2(screen_size.x / 2, 0)
	$bottomWall.position = Vector2(screen_size.x / 2, screen_size.y)
	$rightWall.position = Vector2(screen_size.x, screen_size.y / 2)
	$leftWall.position = Vector2(0, screen_size.y / 2)
	
	# Assuming 'Line2D' is already a node in the scene
	$Line2D.width = 2
	$Line2D.default_color = Color(1, 0, 0)  # Set line color to red
	
	

	
func _process(delta):
	if Input.is_action_just_pressed("fire") and not ball_fired:
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
	ball_instance.position = $laser.global_position + Vector2(-15, 0)
	
	add_child(ball_instance)
	ball_to_launch = ball_instance
	last_ball_position = ball_to_launch.position
	# Connect 'position_changed' signal to the method to update the line
	# ball_instance.connect("position_changed", Callable(self, "_on_Ball_position_changed"))


# This method will be called when the 'position_changed' signal is emitted
func _on_Ball_position_changed(new_position):
	# Add the new position of the ball to the Line2D points
	$Line2D.add_point(new_position)
	

func _input(event):
	if event.is_action_pressed("mirror"):
		_placeMirror()


func _placeMirror():
	var new_mirror = mirror_scene.instantiate()
	new_mirror.position = get_viewport().get_mouse_position()
	add_child(new_mirror)
