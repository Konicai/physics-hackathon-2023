extends ColorRect

var START_COLOUR = [12,19,41]
var END_COLOUR = [46, 61, 111]
# 1 - RGB colour values are increasing
# -1 - RGB colour values are decreasing
var dir= 1; 
var wait_counter = 0
var twinklePack = preload("res://Twinkle.tscn")
#used to randomly create twinkles throughout background
var rng = RandomNumberGenerator.new()
var title_cont
var btn_cont 

func _ready():
	title_cont = get_node("../VBoxContainer/MarginContainer")
	btn_cont = get_node("../VBoxContainer/HBoxContainer")
	


#background colour oscillates back and forth between start 
#and end colour RGB values
func _process(delta):
	#create star
	if(rng.randi_range(0,8) == 0):
		var randX = rng.randi_range(50,ProjectSettings.get_setting(
			"display/window/size/viewport_width")-50)
		var randY = rng.randi_range(50,ProjectSettings.get_setting(
			"display/window/size/viewport_height")-50)
		var title_size = title_cont.get_size()
		var btn_size = btn_cont.get_size()
		var btn_y = btn_cont.get_position().y
		#prevent star generation inside title and buttons
		if(!((randX > title_size.x/4 and randX < 3*title_size.x/4)
		 	and (randY > 2*title_size.y/5 and randY < 4*title_size.y/5))
			and !((randX > btn_size.x/3 and randX < 2*btn_size.x/3)
			and (randY > btn_y-5 and randY < title_size.y+btn_y))):
			var twinkle = twinklePack.instantiate()
			add_child(twinkle)
			twinkle.position = Vector2(randX,randY)
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
	
	

