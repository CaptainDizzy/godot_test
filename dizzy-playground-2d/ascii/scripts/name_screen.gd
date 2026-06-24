extends Node2D

signal player_is_here(n)

func _process(delta: float) -> void:
	var px = %Player.position.x
	var py = %Player.position.y
	var sx = %NameScreen.position.x
	var sy = %NameScreen.position.y
	var sw = %NameScreen/Screen.size.x
	var sh = %NameScreen/Screen.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "NameScreen"
		player_is_here.emit(screen_name)
