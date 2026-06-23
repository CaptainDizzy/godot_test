extends Node2D

@onready var head_symbol: LineEdit = $CharCrtn/HeadInput/LineEdit
@onready var torso_symbol: LineEdit = $CharCrtn/TorsoInput/LineEdit
@onready var larm_symbol: LineEdit = $CharCrtn/LArmInput/LineEdit
@onready var rarm_symbol: LineEdit = $CharCrtn/RArmInput/LineEdit
@onready var lleg_symbol: LineEdit = $CharCrtn/LLegInput/LineEdit
@onready var rleg_symbol: LineEdit = $CharCrtn/RLegInput/LineEdit
@onready var ascii: Node2D = %Player/ASCII

signal game_state(state)
var state = "create_char"

func _ready() -> void:
	torso_symbol.text_changed.connect(_on_torso_changed)
	head_symbol.text_changed.connect(_on_head_changed)
	larm_symbol.text_changed.connect(_on_larm_changed)
	rarm_symbol.text_changed.connect(_on_rarm_changed)
	lleg_symbol.text_changed.connect(_on_lleg_changed)
	rleg_symbol.text_changed.connect(_on_rleg_changed)

func change_game_state(new_state):
	var last_state = state
	state = new_state
	game_state.emit(state)

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
