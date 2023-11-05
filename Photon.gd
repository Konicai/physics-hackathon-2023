extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("photon ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if "Wall" in body.name or "Obsorber" in body.name:
		get_tree().paused = true
		for bod in get_tree().get_nodes_in_group("physics_bodies"):
			bod.linear_velocity = Vector2.ZERO
			bod.angular_velocity = 0
		
		
func _physics_process(delta):
	# Assuming gravity is along the y-axis
	var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")
	var gravity_force = Vector2(0, 1.005) * gravity_value * mass
	apply_central_impulse(-gravity_force * delta)
