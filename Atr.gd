extends Node2D

func fire_ball():
	var ball_instance = ball_scene.instantiate()
	ball_instance.sleeping = false
	ball_instance.position = $laser.global_position + Vector2(0, -15)
	
	add_child(ball_instance)
	ball_to_launch = ball_instance
	last_ball_position = ball_to_launch.position
	# Connect 'position_changed' signal to the method to update the line
	# ball_instance.connect("position_changed", Callable(self, "_on_Ball_position_changed"))
