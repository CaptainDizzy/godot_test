extends Node2D

@onready var head_symbol: LineEdit = %HeadInput/LineEdit
@onready var torso_symbol: LineEdit = %TorsoInput/LineEdit
@onready var larm_symbol: LineEdit = %LArmInput/LineEdit
@onready var rarm_symbol: LineEdit = %RArmInput/LineEdit
@onready var lleg_symbol: LineEdit = %LLegInput/LineEdit
@onready var rleg_symbol: LineEdit = %RLegInput/LineEdit
@onready var ascii: Node2D = %Player/ASCII

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
	
	torso_symbol.text_changed.connect(_on_torso_changed)
	head_symbol.text_changed.connect(_on_head_changed)
	larm_symbol.text_changed.connect(_on_larm_changed)
	rarm_symbol.text_changed.connect(_on_rarm_changed)
	lleg_symbol.text_changed.connect(_on_lleg_changed)
	rleg_symbol.text_changed.connect(_on_rleg_changed)

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
		%Player.scale.x = 1
		%Player.scale.y = 1
	elif current_screen.scrn == "TitleScreen":
		%Player.scale.x = 0.66
		%Player.scale.y = 0.66
	elif current_screen.scrn == "ForkScreen":
		%HUD.visible = false
	elif current_screen.scrn == "PlatformerScreen":
		%HUD.visible = true
		%ParalaxBG.visible = true

func get_cam_pos() -> void:
	%Cam.set_anchor_mode(0)
	var screen = get_node("%" + current_screen.scrn + "/Screen")
	%Cam.global_position.x = screen.global_position.x
	%Cam.global_position.y = screen.global_position.y

func follow_cam_pos() -> void:
	%Cam.set_anchor_mode(1)
	var screen = get_node("%" + current_screen.scrn + "/Screen")
	var cam_w = %PlatformerScreen/Screen.size.x
	var cam_h = %PlatformerScreen/Screen.size.y
	%Cam.global_position.y = screen.global_position.y + (cam_h / 2)
	if %Player.global_position.x <= screen.global_position.x + (cam_w / 2):
		%Cam.global_position.x = screen.global_position.x + (cam_w / 2)
	elif %Player.global_position.x > screen.global_position.x + (cam_w / 2):
		%Cam.global_position.x = %Player.global_position.x

func update_current_screen() -> void:
	var screen = get_node("%" + current_screen.scrn + "/Screen")
	current_screen.x = screen.global_position.x
	current_screen.y = screen.global_position.y
	current_screen.w = screen.size.x
	current_screen.h = screen.size.y

func _on_torso_changed(symbol: String) -> void:
	ascii.set_torso_symbol(symbol)
func _on_head_changed(symbol: String) -> void:
	ascii.set_head_symbol(symbol)
func _on_larm_changed(symbol: String) -> void:
	ascii.set_larm_symbol(symbol)
func _on_rarm_changed(symbol: String) -> void:
	ascii.set_rarm_symbol(symbol)
func _on_lleg_changed(symbol: String) -> void:
	ascii.set_lleg_symbol(symbol)
func _on_rleg_changed(symbol: String) -> void:
	ascii.set_rleg_symbol(symbol)

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
