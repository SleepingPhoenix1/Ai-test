extends KinematicBody2D


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
		var name = i.name
		directions[name] = i.get_node("pr").value
	
	#print(str(directions.values().max()))
	velocity = find_node(str(dict_find(directions,directions.values().max()))).cast_to/8
	move_and_slide(velocity*speed, Vector2.UP)

func dict_find(dict: Dictionary, value):
	var found = dict.values().find(value)
	return dict.keys()[found] if found > -1 else false
