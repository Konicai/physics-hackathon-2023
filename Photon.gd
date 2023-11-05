extends RigidBody2D
var won_round = false
var lost_round = false
var frozen = false
# Called when the node enters the scene tree for the first time.
func _ready():
	print("photon ready")
	frozen = false

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func didWin():
	return won_round

func didLose():
	return lost_round

func isFrozen():
	return frozen

func _on_body_entered(body):
#	print("collided with: " + body.name)
	if "Wall" in body.name or "Obsorber" in body.name:
#		get_tree().paused = true
		print("freezing")
		frozen = true
		lost_round = true
		
		
func _physics_process(delta):
	# Assuming gravity is along the y-axis
	var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")
	var gravity_force = Vector2(0, 1.002) * gravity_value * mass
	apply_central_impulse(-gravity_force * delta)


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("BSI: " + str(body_shape_index))
	if body_shape_index > 0:
		frozen = true
		won_round = true
		
