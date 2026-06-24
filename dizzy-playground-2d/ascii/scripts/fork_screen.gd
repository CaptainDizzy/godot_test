extends Node2D

signal player_is_here(n)
var enter_count = 0
var entered := false

func _process(delta: float) -> void:
	var px = %Player.position.x
	var py = %Player.position.y
	var sx = %ForkScreen.position.x
	var sy = %ForkScreen.position.y
	var sw = %ForkScreen/Screen.size.x
	var sh = %ForkScreen/Screen.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "ForkScreen"
		player_is_here.emit(screen_name)
		if not entered:
			enter_count += 1
			entered = true
	else:
		entered = false
	
	if enter_count == 2:
		%ForkMessage.text = "Want to choose another path?"
	elif enter_count == 3:
		%ForkMessage.text = "You've got the gist of it..."
	elif enter_count == 4:
		%ForkMessage.text = "Ya winning, son?"
	elif enter_count >= 5:
		%ForkMessage.text = "I'm not updating this every time."
	elif enter_count >= 8:
		%ForkMessage.text = "..."
	
