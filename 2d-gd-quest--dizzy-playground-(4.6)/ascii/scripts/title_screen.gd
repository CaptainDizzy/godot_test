extends Node2D

signal player_is_here(n)
var enter_count = 0
var entered := false

func _process(delta: float) -> void:
	var px = %Player.position.x
	var py = %Player.position.y
	var sx = %TitleScreen.position.x
	var sy = %TitleScreen.position.y
	var sw = %TitleScreen/Screen.size.x
	var sh = %TitleScreen/Screen.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "TitleScreen"
		player_is_here.emit(screen_name)
		if not entered:
			enter_count += 1
			entered = true
	else:
		entered = false
	
	if px > sx + (sw / 2) and enter_count == 1:
		%Subtitle.text = "I made you smaller so you look at the title longer."
	if enter_count == 2:
		%Subtitle.text = "Oh, you're back... this is awkward."
	elif enter_count == 3:
		%Subtitle.text = "An Interactive Showcase of Blah Blah Blah..."
	elif enter_count == 4:
		%Subtitle.text = "Orange you glad I didn't say Banana?"
	elif enter_count >= 5:
		%Subtitle.text = "Just go play the game already!"
