extends Node2D

signal player_is_here(n)
signal intro_2_music()

var enter_count = 0
var entered := false

func _process(delta: float) -> void:
	var px = %Player.global_position.x
	var py = %Player.global_position.y
	var sx = %NameScreen.global_position.x
	var sy = %NameScreen.global_position.y
	var sw = %NameScreen/Screen.size.x
	var sh = %NameScreen/Screen.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "NameScreen"
		player_is_here.emit(screen_name)
		intro_2_music.emit()
		if not entered:
			enter_count += 1
			entered = true
	else:
		entered = false
	
	if enter_count == 2:
		%CharacterName/Title.text = ""
		%CharacterName/Title2.text = "Want to change your name?"
