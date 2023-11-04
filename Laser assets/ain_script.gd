extends Node2D

var ball_scene = preload("res://Laser assets/ball.tscn")
var launch_speed = Vector2(0, -1000)  # Launching the ball upwards requires negative Y value
var points = PackedVector2Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Path.points = points
	var screen_size = get_viewport_rect().size
	$StaticBody2D.position = screen_size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire"):
		fire_ball()

func _apply_impulse(ball_instance):
	print("Applying impulse")
	ball_instance.apply_impulse(Vector2.ZERO, launch_speed)

func _on_Ball_position_changed(ball):
	points.append(ball.position)
	$Path.points = points

func fire_ball():
	var ball_instance = ball_scene.instantiate()
	ball_instance.sleeping = false
	ball_instance.position = $StaticBody2D.global_position + Vector2(0, -100)  # Offset to ensure it's clear of the launcher
	add_child(ball_instance)
	# Apply an impulse in the upward direction
	# Ensure we use the physics frame to apply the impulse
	call_deferred("_apply_impulse", ball_instance)
	

