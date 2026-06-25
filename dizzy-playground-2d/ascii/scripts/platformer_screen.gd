extends Node2D

signal player_is_here(s)
signal platform_state
var enter_count = 0
var entered := false

func _process(delta: float) -> void:
	var px = %Player.position.x
	var py = %Player.position.y
	var sx = %PlatformerScreen.position.x
	var sy = %PlatformerScreen.position.y
	var sw = %PlatformerScreen/Screen.size.x
	var sh = %PlatformerScreen/Screen.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "PlatformerScreen"
		player_is_here.emit(screen_name)
		platform_state.emit()
		if not entered:
			enter_count += 1
			entered = true
	else:
		entered = false
	
	if enter_count == 2:
		%Message.text = "Did you not learn last time??"
	

func _on_player_first_landing() -> void:
	%Message.text = "OOF! Didn't quite stick the landing, huh?"
