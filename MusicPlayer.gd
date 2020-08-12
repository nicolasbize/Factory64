## A simple player that loops through all the songs with a pause in the middle
class_name MusicPlayer
extends Node

onready var music := $Music
onready var timer := $Timer

export (int) var wait_between_songs := 10

var current_index := -1

# Called when the node enters the scene tree for the first time.
func _ready():
	play_next()
	
func play_next():
	current_index += 1
	if current_index > music.get_child_count() - 1:
		current_index = 0
	var song : AudioStreamPlayer = music.get_children()[current_index]
	song.play()

func _on_Timer_timeout():
	play_next()

func _on_music_finished():
	timer.start(wait_between_songs)
