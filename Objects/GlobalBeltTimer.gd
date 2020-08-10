## Keeps belt animations in sync through a common timer
## Singleton GlobalBeltTimer
extends Timer

export(float) var playback_speed: float = 0.8

func _on_GlobalBeltTimer_timeout() -> void:
	start(playback_speed)
