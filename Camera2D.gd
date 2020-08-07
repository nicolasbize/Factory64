extends Camera2D

export(int) var speed = 10

var target_position = null

func _process(delta):
	if target_position != null:
		if global_position != target_position:
			if global_position.x < target_position.x:
				global_position.x += 1
			elif global_position.x > target_position.x:
				global_position.x -= 1
			if global_position.y < target_position.y:
				global_position.y += 1
			elif global_position.y > target_position.y:
				global_position.y -= 1
		else:
			target_position = null
	else:
		if Input.is_action_pressed("ui_left") and global_position.x > limit_left:
			global_position.x -= 1
		if Input.is_action_pressed("ui_right") and global_position.x < limit_right - 64:
			global_position.x += 1
		if Input.is_action_pressed("ui_up") and global_position.y > limit_top:
			global_position.y -= 1
		if Input.is_action_pressed("ui_down") and global_position.y < limit_bottom - 64:
			global_position.y += 1

func move_to(position):
	target_position = position - Vector2(28, 18)
