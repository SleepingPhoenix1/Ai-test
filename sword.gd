extends Node2D

var state = 0

func _ready():
	pass


func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("left_click"):
		if state == 0:
			$Area2D/AnimationPlayer.play("sword_swing")
			state = 1
		elif state == 1:
			$Area2D/AnimationPlayer.play("sword_swing_back")
			state = 0
	scale.y = sign(get_global_mouse_position().x-global_position.x)
	
	if sign(get_global_mouse_position().y-global_position.y) == -1:
		get_parent().move_child(self, 0)
	else: get_parent().move_child(self, 5)
