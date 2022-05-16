extends KinematicBody2D

export var fear = [] 

var speed = 50

var velocity = Vector2.ZERO
var directions = {
	"up": 0,
	"up_right1":1,
	"up_right2":2,
	"right":3,
	"down":4,
	"down_right1":5,
	"down_right2":6,
	"up_left1":7,
	"up_left2":8,
	"left":9,
	"down_left1":10,
	"down_left2":11
}

func _process(delta):
	
	for i in $directions.get_children():
		if Global.chased:
			i.get_node("text").text = str(i.cast_to.dot(-get_node("../attract").global_position.direction_to(global_position)/8 )+1)
			i.get_node("pr").value = i.cast_to.dot(-get_node("../attract").global_position.direction_to(global_position)/8 )+1
		else:
			i.get_node("text").text = "0"
			i.get_node("pr").value = 0
		
	for i in $directions.get_children():
		directions[i.name] = i.get_node("pr").value
	
	if !$visibility_box.get_overlapping_areas():
		Global.chased = false
	else: Global.chased = true
	
	if !$fear_box.get_overlapping_areas():
		Global.fear = false
	else: Global.fear = true
	#print(str(directions.values().max()))
	
		
	if Global.chased:
		if !Global.fear:
			velocity = find_node(str(dict_find(directions,directions.values().max()))).cast_to/8
		else: 
			velocity = find_node(str(directions.keys()[-2])).cast_to/8
			print(directions.keys()[-2])
	else: velocity = Vector2.ZERO
	move_and_slide(velocity*speed, Vector2.UP)
	
	

func dict_find(dict: Dictionary, value):
	var found = dict.values().find(value)
	return dict.keys()[found] if found > -1 else false
