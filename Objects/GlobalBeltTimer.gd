extends Timer

export(float) var playback_speed = 0.8

func _on_GlobalBeltTimer_timeout():
	start(playback_speed)
