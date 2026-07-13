extends AudioStreamPlayer

@onready var intro_tune: AudioStream = preload("res://ascii/assets/audio/intro_1.wav")
@onready var intro_2: AudioStream = preload("res://ascii/assets/audio/intro_2.wav")
@onready var intro_3: AudioStream = preload("res://ascii/assets/audio/intro_3.wav")
@onready var intro_full: AudioStream = preload("res://ascii/assets/audio/intro_4.wav")

var current_song = intro_tune
var next_song = intro_tune

#func _ready() -> void:
	

func _on_fake_button_start_music() -> void:
	stream = intro_tune
	play()

func _on_finished() -> void:
	if next_song != current_song:
		stream = next_song
		play()
		current_song = next_song
	else:
		play()

func _on_title_music() -> void:
	next_song = intro_full
func _on_intro_2_music() -> void:
	next_song = intro_2
func _on_intro_3_music() -> void:
	next_song = intro_3
func _on_platformer_music() -> void:
	stop()
