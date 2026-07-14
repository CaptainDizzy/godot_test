extends Node2D

signal player_is_here(s)
signal platformer_music()
signal platform_state(state)
signal add_dollars(d: float)
signal bounce_player(v: float)
signal flag_down(flag: Node2D)
signal level_completed()
var enter_count = 0
var entered := false

func _ready() -> void:
	for mob in %Mobs.get_children():
		if mob.has_signal("plr_bounce"):
			mob.plr_bounce.connect(_on_plr_bounce)
	
	for box in %LevelObjs.get_children():
		if box.has_signal("has_dollars"):
			box.has_dollars.connect(_on_box_has_dollars)

func _process(delta: float) -> void:
	var px = %Player.global_position.x
	var py = %Player.global_position.y
	var sx = %PlatformerScreen.global_position.x
	var sy = %PlatformerScreen.global_position.y
	var sw = %PlatformerScreen/Screen/BGColor.size.x
	var sh = %PlatformerScreen/Screen/BGColor.size.y
	
	if px >= sx and px <= sx + sw and py >= sy and py <= sy + sh:
		var screen_name = "PlatformerScreen"
		player_is_here.emit(screen_name)
		platform_state.emit("platformer")
		platformer_music.emit()
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

func _on_plr_bounce(v: float) -> void:
	bounce_player.emit(v)

func _on_box_has_dollars(d: float) -> void:
	add_dollars.emit(d)

func _on_player_pit_fall(body) -> void:
	%Player/ASCII.play_platformer_hurt_animation()
	%Player.global_position.x = %PlatformerScreen/Screen/BGColor.global_position.x + 960
	%Player.global_position.y = %PlatformerScreen/Screen/BGColor.global_position.y + 60
	%Player.take_damage(1,0)

func _on_flag_end_level(f) -> void:
	%Flag.play_flagdrop_animation()
	flag_down.emit(f)
	await get_tree().create_timer(1).timeout

func _on_end_level_body_exited(body: Node2D) -> void:
	level_completed.emit()
	var target_screen = %ForkScreen/Screen
	%Player.global_position.x = target_screen.global_position.x + target_screen.size.x / 2
	%Player.global_position.y = target_screen.global_position.y + target_screen.size.y / 2
