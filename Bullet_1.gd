extends KinematicBody2D

var deceleration
var pl_posit


var velocity = Vector2.ZERO

func shoot_bullet(start_vel, decel):
	velocity = start_vel
	deceleration = decel
	

func _process(delta):
	move_and_slide(velocity,Vector2.UP)
	velocity = velocity.linear_interpolate(Vector2.ZERO, deceleration)
	if abs(velocity.x) <=1:
		velocity.x = 0
	if abs(velocity.y) <=1:
		velocity.y = 0
	
	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			velocity = velocity.bounce(collision.normal)


func move_to_player():
	pl_posit = Global.Player.global_position
	pl_posit = Global.Player.global_position
	if global_position !=pl_posit:
		global_position = global_position.linear_interpolate(pl_posit,0.05)
		if abs(global_position.x - pl_posit.x) <2:
			global_position.x = pl_posit.x
		if abs(global_position.y - pl_posit.y) <2:
			global_position.y = pl_posit.y
