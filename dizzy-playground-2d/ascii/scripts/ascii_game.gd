extends Node2D

@onready var current_screen = {
	scrn = "StartingScreen",
	x = %Cam.position.x,
	y = %Cam.position.y,
	w = 1920,
	h = 1080
	}

var game_state: String = ""

func _ready() -> void:
	%DizzyTransitions.visible = true
	%DizzyTransitions.transition_in_wipe_right()
	await get_tree().create_timer(1).timeout
	%DizzyTransitions.visible = false

func _process(delta: float) -> void:
	if current_screen.scrn != "PlatformerScreen" and current_screen.scrn != "ShmupScreen":
		get_cam_pos()
	elif current_screen.scrn == "PlatformerScreen" or current_screen.scrn == "ShmupScreen":
		follow_cam_pos()
	update_current_screen()
	
	if current_screen.scrn == "StartingScreen":
		%HUD.visible = false
	elif current_screen.scrn == "NameScreen":
		pass
	elif current_screen.scrn == "CreditsScreen":
		reset_player_scale()
	elif current_screen.scrn == "TitleScreen":
		adventure_player_scale()
	elif current_screen.scrn == "ForkScreen":
		adventure_player_scale()
	elif current_screen.scrn == "PlatformerScreen":
		platformer_player_scale()
		%HUD.visible = true
		%ParalaxBG.visible = true

func reset_player_scale() -> void:
	%Player.scale.x = 1
	%Player.scale.y = 1
	%Player/Collision.scale.x = 1
	%Player/Collision.scale.y = 1
	%Player/Collision.position.y = -33
	%Player/StompBox.scale.x = 1

func adventure_player_scale() -> void:
	%Player.scale.x = 0.66
	%Player.scale.y = 0.66
	%Player/Collision.scale.x = 1
	%Player/Collision.scale.y = 1
	%Player/Collision.position.y = -33
	%Player/StompBox.scale.x = 1

func platformer_player_scale() -> void:
	%Player.scale.x = 0.66
	%Player.scale.y = 0.66
	%Player/Collision.scale.x = 1.125
	%Player/Collision.scale.y = 1.66
	%Player/Collision.position.y = -80
	%Player/StompBox.scale.x = 1.125 

func get_cam_pos() -> void:
	%Cam.set_anchor_mode(0)
	var screen = get_node("%" + current_screen.scrn + "/Screen")
	%Cam.global_position.x = screen.global_position.x
	%Cam.global_position.y = screen.global_position.y

func follow_cam_pos() -> void:
	%Cam.set_anchor_mode(1)
	var screen = get_node("%" + current_screen.scrn + "/Screen")
	var cam_w = get_viewport_rect().size.x
	var cam_h = get_viewport_rect().size.y
	%Cam.global_position.y = screen.global_position.y + (cam_h / 2)
	if %Player.global_position.x <= screen.global_position.x + (cam_w / 2):
		%Cam.global_position.x = screen.global_position.x + (cam_w / 2)
	elif %Player.global_position.x > screen.global_position.x + (cam_w / 2) and %Player.global_position.x <= screen.global_position.x + current_screen.w - (cam_w / 2):
		%Cam.global_position.x = %Player.global_position.x
	elif %Player.global_position.x >= screen.global_position.x + current_screen.w - (cam_w / 2):
		%Cam.global_position.x = screen.global_position.x + screen.size.x - (cam_w / 2)

func update_current_screen() -> void:
	var screen = get_node("%" + current_screen.scrn + "/Screen")
	current_screen.x = screen.global_position.x
	current_screen.y = screen.global_position.y
	current_screen.w = screen.size.x
	current_screen.h = screen.size.y

func _on_changed_game_state(state: String) -> void:
	game_state = state

func _on_starting_screen_here(s: String) -> void:
	current_screen.scrn = s
func _on_name_screen_here(s: String) -> void:
	current_screen.scrn = s
func _on_credits_screen_here(s: String) -> void:
	current_screen.scrn = s
func _on_title_screen_here(s: String) -> void:
	current_screen.scrn = s
func _on_fork_screen_here(s: String) -> void:
	current_screen.scrn = s
func _on_platformer_screen_here(s: String) -> void:
	current_screen.scrn = s
