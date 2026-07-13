extends Node2D

signal player_is_here(n)
signal intro_3_music()

var enter_count = 0
var entered := false

func _process(delta: float) -> void:
	var px = %Player.position.x
	var py = %Player.position.y
	var sx = %CreditsScreen.position.x
	var sy = %CreditsScreen.position.y
	var sw = %CreditsScreen/Screen.size.x
	var sh = %CreditsScreen/Screen.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "CreditsScreen"
		player_is_here.emit(screen_name)
		intro_3_music.emit()
		if not entered:
			enter_count += 1
			entered = true
	else:
		entered = false
	
