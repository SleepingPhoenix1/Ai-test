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
	
	$Area2D/Sword1.frame = 2-(Global.ammo-1)
	if Global.ammo == 3:
		$Area2D/state_1.disabled = false
		$Area2D/state_2.disabled = true
		$Area2D/state_3.disabled = true
	if Global.ammo == 2:
		$Area2D/state_1.disabled = false
		$Area2D/state_2.disabled = true
		$Area2D/state_3.disabled = true
	if Global.ammo == 1:
		$Area2D/state_1.disabled = false
		$Area2D/state_2.disabled = true
		$Area2D/state_3.disabled = true
