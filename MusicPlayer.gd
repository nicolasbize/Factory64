## A simple player that loops through all the songs with a pause in the middle
## Autoloaded
extends AudioStreamPlayer

onready var timer := $Timer

export (Array, AudioStream) var song_list = []
export (AudioStream) var end_song = null
export (int) var wait_between_songs := 10

var current_index := -1
var has_won := false

func _ready():
	play_next()
	GameState.connect("game_won", self, "on_finished_game")

func play_next():
	current_index += 1
	if current_index > song_list.size() - 1:
		current_index = 0
	stream = song_list[current_index]
	play()

func _on_Timer_timeout():
	play_next()

func _on_MusicPlayer_finished():
	if not has_won:
		timer.start(wait_between_songs)

func on_finished_game():
	stream = end_song
	has_won = true
	play()
