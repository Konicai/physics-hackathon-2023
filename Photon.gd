extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("photon ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("collided with")
	print(body.name)
	
	if body.name == "rightWall":
		print("Ball has collided with the right wall!")
		

