extends Node2D

signal player_is_here(n)
signal title_screen

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
		title_screen.emit()
	
	if px > sx + (sw / 2):
		%Subtitle.text = "I made you smaller so you look at the title longer."
