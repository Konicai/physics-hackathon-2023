extends ColorRect

var START_COLOUR = [12,19,41]
var END_COLOUR = [46, 61, 111]
# 1 - RGB colour values are increasing
# -1 - RGB colour values are decreasing
var dir= 1; 
var wait_counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#background colour oscillates back and forth between start 
#and end colour RGB values
func _process(delta):
	if(wait_counter > 0):
		if(wait_counter == 15):
			wait_counter = 0
		else:
			wait_counter += 1
		return
	color = Color(color.r+(0.002*dir), color.g+(0.002*dir),
			 color.b+(0.002*dir))
	if(color.r*255 > END_COLOUR[0] and color.g*255 > END_COLOUR[1]
		and color.b*255 > END_COLOUR[2]):
			wait_counter = 1
			dir=-1
	elif(color.r*255 < START_COLOUR[0] and color.g*255 < START_COLOUR[1]
		and color.b*255 < START_COLOUR[2]):
			wait_counter = 1
			dir=1
	
	

