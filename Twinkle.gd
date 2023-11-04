extends Sprite2D

#flag used to tell whether the star is at the beginning or end
#of it life-cycle
var start = false
var dir = 1

func _ready():
	pass

func _process(delta):
	#end of this objects life-cycle
	if(start and modulate.a < 0):
		queue_free()
	modulate = Color(modulate.r,modulate.g,modulate.b,
						modulate.a+(dir*0.05))
	if(modulate.a > 1):
		dir = -1
	start = true
