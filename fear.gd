extends Area2D



var selected = false



func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 1)
#		look_at(get_global_mouse_position())
	

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false


func _on_fear_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
