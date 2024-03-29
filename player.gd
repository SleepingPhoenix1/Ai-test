extends KinematicBody2D


var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var mouse_vector = Vector2.ZERO

var MAX_SPEED = 130
var ACCELERATION = 30

onready var AnimTree = $AnimationTree
onready var animNode = AnimTree.get("parameters/playback")


onready var bullet_1 = preload("res://Bullet.tscn")


var ammo = 3


func _ready():
	Global.Player = self


func _process(delta):
	controls()
	animation()
	#areas that repulse the enemy
	$repulsion_node.look_at(get_global_mouse_position())
	
	#gets mouse direction relative to the player
	mouse_vector = Vector2(sign(get_global_mouse_position().x-global_position.x),sign(get_global_mouse_position().y-global_position.y))
	
	if Input.is_action_just_pressed("right_click") and ammo > 0:
		_shooting()
	
	Global.ammo = ammo
	
	
	
	if $Pickup_area.get_overlapping_bodies().size()>0:
		for i in $Pickup_area.get_overlapping_bodies().size():
			var body = $Pickup_area.get_overlapping_bodies()[i]
			if body.velocity == Vector2.ZERO:
				body.move_to_player()
			if body.global_position == global_position:
				body.queue_free()
				ammo +=1
				print(ammo)
	
	


func controls():
	#get input direction
	direction.x = Input.get_action_strength("right")- Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down")- Input.get_action_strength("up")
	
	#normalize the direction
	direction = direction.normalized()
	
	#if any key is pressed accelerate
	if direction != Vector2.ZERO:
		velocity += direction * ACCELERATION
		#max speed
		velocity = velocity.clamped(MAX_SPEED-ammo*13)
		
	else:
		#interpolates velocity to 0 aka deceleration
		velocity = velocity.linear_interpolate(Vector2.ZERO, 0.17)
	
	
	move_and_slide(velocity, Vector2.UP)
	
	#if velocity is very small round it to 0
	if abs(velocity.x) <1: velocity.x = 0
	if abs(velocity.y)<1: velocity.y = 0
	

func animation():
	AnimTree.set("parameters/idle/blend_position", mouse_vector)
	AnimTree.set("parameters/walk/blend_position", mouse_vector)
	
	#flip sprite if mouse to the left of the player
	if mouse_vector.x == -1:
		$Player.flip_h = true
	else: $Player.flip_h = false
	
	if velocity != Vector2.ZERO:
		animNode.travel("walk")
		$footsteps.emitting = true
	elif velocity == Vector2.ZERO:
		animNode.travel("idle")
		$footsteps.emitting = false
	

func _shooting():
	var bullet_inst = bullet_1.instance()
	get_parent().get_node("TileMap").add_child(bullet_inst)
	bullet_inst.global_position = global_position
	bullet_inst.shoot_bullet(Vector2(get_global_mouse_position().x-global_position.x,get_global_mouse_position().y-global_position.y).normalized()*300,0.025)
	ammo -=1
	
	
	
	





