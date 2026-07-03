extends Node2D

signal player_is_here(n)
var enter_count = 0
var entered := false

func _process(delta: float) -> void:
	var px = %Player.position.x
	var py = %Player.position.y
	var sx = %StartingScreen.position.x
	var sy = %StartingScreen.position.y
	var sw = %StartingScreen/Screen.size.x
	var sh = %StartingScreen/Screen.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "StartingScreen"
		player_is_here.emit(screen_name)
		if not entered:
			enter_count += 1
			entered = true
	else:
		entered = false
	
	if enter_count == 2:
		%CharacterCreation/Title.text = "Don't like the way you look?"
