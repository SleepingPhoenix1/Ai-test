extends Node2D




func _process(delta):
	$line.clear_points()
	$line.add_point($player.global_position)
	$line.add_point($attract.global_position)
	
	
	#print(-$Node2D.global_position.direction_to(Vector2.ZERO)/8)
	


func _on_CheckBox_toggled(button_pressed):
	Global.chased = button_pressed
