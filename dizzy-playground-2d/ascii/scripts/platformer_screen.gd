extends Node2D

signal player_is_here(s)
signal platform_state(state)
var enter_count = 0
var entered := false

func _process(delta: float) -> void:
	var px = %Player.position.x
	var py = %Player.position.y
	var sx = %PlatformerScreen.position.x
	var sy = %PlatformerScreen.position.y
	var sw = %PlatformerScreen/Screen/BGColor.size.x
	var sh = %PlatformerScreen/Screen/BGColor.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "PlatformerScreen"
		player_is_here.emit(screen_name)
		platform_state.emit("platformer")
		if not entered:
			enter_count += 1
			entered = true
	else:
		entered = false
	
	if enter_count >= 2:
		%Message.text = "Back so soon?"
	

func _on_player_first_landing() -> void:
	if enter_count == 1:
		%Message.text = "OOF! Didn't quite stick the landing, huh?"
	elif enter_count >= 2:
		%Message.text = "Did you not learn last time??"


func _on_box_was_hit(box_name: Variant) -> void:
	var box_label = get_node("%" + box_name + "/Skin/CenterContainer/Label")
	box_label.text = ""
