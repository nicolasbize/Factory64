extends Camera2D

export(int) var speed = 10

func _process(delta):
	if Input.is_action_pressed("ui_left") and global_position.x > limit_left:
		global_position.x -= 1
	if Input.is_action_pressed("ui_right") and global_position.x < limit_right - 64:
		global_position.x += 1
	if Input.is_action_pressed("ui_up") and global_position.y > limit_top:
		global_position.y -= 1
	if Input.is_action_pressed("ui_down") and global_position.y < limit_bottom - 64:
		global_position.y += 1
