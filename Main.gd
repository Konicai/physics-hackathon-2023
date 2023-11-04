extends Node

@export var Ball: PackedScene = preload("res://Ball.tscn")
@export var Mirror: PackedScene = preload("res://Mirror.tscn")


func _input(event):
	if event.is_action_pressed("click"):
		var new_ball = Ball.instantiate()
		new_ball.position = get_viewport().get_mouse_position()
		add_child(new_ball)
		
	if event.is_action_pressed("mirror"):
		_placeMirror()


func _placeMirror():
	var new_mirror = Mirror.instantiate()
	new_mirror.position = get_viewport().get_mouse_position()
	add_child(new_mirror)


