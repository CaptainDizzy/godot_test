extends Node2D

@onready var head_symbol: LineEdit = %HeadInput/LineEdit
@onready var torso_symbol: LineEdit = %TorsoInput/LineEdit
@onready var larm_symbol: LineEdit = %LArmInput/LineEdit
@onready var rarm_symbol: LineEdit = %RArmInput/LineEdit
@onready var lleg_symbol: LineEdit = %LLegInput/LineEdit
@onready var rleg_symbol: LineEdit = %RLegInput/LineEdit
@onready var ascii: Node2D = %Player/ASCII

var game_state: String = ""
var current_screen = {
	x = %Cam.position.x,
	y = %Cam.position.y,
	w = 1920,
	h = 1080
	}

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
	get_cam_pos()

func get_cam_pos() -> void:
	var viewport_size = get_viewport_rect().size
	var cam_zoom = %Cam.zoom
	var cam_w = viewport_size.x / cam_zoom.x
	var cam_h = viewport_size.y / cam_zoom.y
	

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
