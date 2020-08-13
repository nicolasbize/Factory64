## A simple player that loops through all the songs with a pause in the middle
## Autoloaded
extends AudioStreamPlayer

onready var timer := $Timer

export (Array, AudioStream) var song_list = []
export (int) var wait_between_songs := 10

var current_index := -1

func _ready():
	play_next()

func play_next():
	current_index += 1
	if current_index > song_list.size() - 1:
		current_index = 0
	stream = song_list[current_index]
	play()

func _on_Timer_timeout():
	play_next()
	print("playing next")

func _on_MusicPlayer_finished():
	timer.start(wait_between_songs)
