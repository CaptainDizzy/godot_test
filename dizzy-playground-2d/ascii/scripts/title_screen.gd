extends Node2D

signal player_is_here(n)
signal title_music

var enter_count = 0
var entered := false

func _process(delta: float) -> void:
	var px = %Player.global_position.x
	var py = %Player.global_position.y
	var sx = %TitleScreen.global_position.x
	var sy = %TitleScreen.global_position.y
	var sw = %TitleScreen/Screen.size.x
	var sh = %TitleScreen/Screen.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "TitleScreen"
		player_is_here.emit(screen_name)
		title_music.emit()
		if not entered:
			enter_count += 1
			entered = true
	else:
		entered = false
	
	if px > sx + (sw * 0.33) and enter_count == 1:
		%Subtitle.text = "I made you small so you have to\nlook at the title longer."
	if px > sx + (sw * 0.66) and enter_count == 1:
		%Subtitle.text = "But I guess you could just run\nby holding the shift key..."
	if enter_count == 2:
		%Subtitle.text = "Oh, you're back... this is awkward."
	elif enter_count == 3:
		%Subtitle.text = "An Interactive Showcase of Blah Blah Blah..."
	elif enter_count == 4:
		%Subtitle.text = "Orange you glad I didn't say Banana?"
	elif enter_count >= 5:
		%Subtitle.text = "Just go play the game already!"
