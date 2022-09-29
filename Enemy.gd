extends KinematicBody2D




var velocity = Vector2.ZERO

var goal

var MAX_SPEED = 60
var ACCELERATION = 15

var repulsion_nodes
var player_repulsion_node

func _ready():
	goal = Global.Player
	repulsion_nodes = get_tree().get_nodes_in_group("repulsion")
	player_repulsion_node = get_tree().get_nodes_in_group("repulsion")[1]


func _process(delta):
	#This line rotates RayCast to always look at the Player 
	$line_of_sight.look_at(Global.Player.global_position)
	
	if $line_of_sight.is_colliding() and $line_of_sight.get_collider().is_in_group("Player"):
		movement()
	



func movement():
	if goal:
		var direction = goal.global_position - global_position
		direction = direction.normalized()
		
		if direction != Vector2.ZERO:
			if global_position.distance_to(repulsion_nodes[0].global_position) < repulsion_nodes[0].get_node("Area").shape.radius:
				direction += (global_position-repulsion_nodes[0].global_position).normalized() * (inverse_number_to_second(global_position.distance_to(repulsion_nodes[0].global_position), repulsion_nodes[0].get_node("Area").shape.radius)+0.7)
				#velocity.x = -velocity.y
				#velocity.y = -velocity.x
			if global_position.distance_to(player_repulsion_node.global_position) < player_repulsion_node.get_node("Area").shape.radius:
				direction += (global_position-player_repulsion_node.global_position).normalized() * (inverse_number_to_second(global_position.distance_to(player_repulsion_node.global_position), player_repulsion_node.get_node("Area").shape.radius)+0.9)
				velocity.x = -velocity.y
				velocity.y = -velocity.x
			velocity += direction * ACCELERATION
			velocity = velocity.clamped(MAX_SPEED)
		else:
			velocity = velocity.linear_interpolate(Vector2.ZERO, 0.2)
			
		
		
		
		
		
		
		velocity = move_and_slide(velocity)
	

func inverse_number_to_second(x,y):
	return (y-x)/y
