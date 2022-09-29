extends KinematicBody2D

var deceleration


func _ready():
	shoot_bullet(300,0.05)

var velocity = Vector2.ZERO

func shoot_bullet(start_vel, decel):
	velocity.x = start_vel
	deceleration = decel
	

func _process(delta):
	move_and_slide(velocity,Vector2.UP)
	velocity = velocity.linear_interpolate(Vector2.ZERO, deceleration)
	if velocity.x <=0.1:
		velocity.x = 0
