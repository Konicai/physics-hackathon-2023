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
	if "Wall" in body.name or "Absorber" in body.name:
		print("freezing")
		frozen = true
		lost_round = true
