extends KinematicBody2D


var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var mouse_vector = Vector2.ZERO

var MAX_SPEED = 110
var ACCELERATION = 30

onready var AnimTree = $AnimationTree
onready var animNode = AnimTree.get("parameters/playback")


onready var bullet_1 = preload("res://Bullet.tscn")


func _ready():
	Global.Player = self


func _process(delta):
	controls()
	animation()
	#areas that repulse the enemy
	$repulsion_node.look_at(get_global_mouse_position())
	
	#gets mouse direction relative to the player
	mouse_vector = Vector2(sign(get_global_mouse_position().x-global_position.x),sign(get_global_mouse_position().y-global_position.y))


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
		velocity = velocity.clamped(MAX_SPEED)
		
	else:
		#interpolates velocity to 0 aka deceleration
		velocity = velocity.linear_interpolate(Vector2.ZERO, 0.15)
	
	move_and_slide(velocity, Vector2.UP)
	
	#if velocity is very small round it to 0
	if abs(velocity.x) <0.2: velocity.x = 0
	if abs(velocity.y)<0.2: velocity.y = 0
	

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
	pass


