extends Control

onready var music_check := $Panel/MusicButton/Sprite
onready var sound_check := $Panel/SoundButton/Sprite

var music_enabled := true
var sound_enabled := true

func show_pause() -> void:
	rect_position = Vector2.ZERO
	get_tree().paused = true

func hide_pause() -> void:
	rect_position = Vector2.ONE * -500
	get_tree().paused = false

func _on_MusicButton_click(el):
	music_enabled = !music_enabled
	AudioServer.set_bus_mute(2, not AudioServer.is_bus_mute(2))
	music_check.frame = 1 if music_enabled else 0

func _on_SoundButton_click(el):
	sound_enabled = !sound_enabled
	AudioServer.set_bus_mute(1, not AudioServer.is_bus_mute(1))
	sound_check.frame = 1 if sound_enabled else 0


func _on_ReturnToGameButton_click(el):
	hide_pause()
