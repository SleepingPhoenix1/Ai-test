extends Node2D



export(NodePath) var point2

func _process(delta):
	$line.clear_points()
	$line.add_point($player.global_position)
	$line.add_point($attract.global_position)
	
	for i in $player/directions.get_children():
		i.get_node("text").text = str(i.cast_to.dot(-$attract.global_position.direction_to($player.global_position)/8)+1)
		i.get_node("pr").value = i.cast_to.dot(-$attract.global_position.direction_to($player.global_position)/8 + $fear.global_position.direction_to($player.global_position)/9)+1
	#print(-$Node2D.global_position.direction_to(Vector2.ZERO)/8)
