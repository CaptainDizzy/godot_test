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
	
	if px > sx + (sw * 0) and enter_count == 1:
		%Credits.text = "Music by Dizzy."
	if px > sx + (sw * 0.20) and enter_count == 1:
		%Credits.text = "Art by Dizzy."
	if px > sx + (sw * 0.40) and enter_count == 1:
		%Credits.text = "Art by Dizzy\nWell, the ASCII art is using a free font with a\nrandom generator, but the ASCII art itself\nand the generator was made by Dizzy,\nand any non-ASCII art is also Dizzy's art."
	if px > sx + (sw * 0.60) and enter_count == 1:
		%Credits.text = "Look, this is a portfolio project, so everything\nwas made by Dizzy, and I'm sure it's pretty obvious.\nAll rights reserved and whatnot."
	if px > sx + (sw * 0.80) and enter_count == 1:
		%Credits.text = "The only AI used for this project\nwas for teaching Godot and debugging."
	if px > sx + (sw * 0.90) and enter_count == 1:
		%Credits.text = str(CharacterManager.char_name)
	if enter_count > 2:
		%Credits.text = "Look, I'm not going to keep listing the credits every time\nyou want to change your name or appearance..."
	
