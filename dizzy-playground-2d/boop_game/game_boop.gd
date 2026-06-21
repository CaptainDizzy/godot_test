extends Node2D

@onready var head_symbol: LineEdit = $GUI/HeadInput/LineEdit
@onready var torso_symbol: LineEdit = $GUI/TorsoInput/LineEdit
@onready var larm_symbol: LineEdit = $GUI/LArmInput/LineEdit
@onready var rarm_symbol: LineEdit = $GUI/RArmInput/LineEdit
@onready var lleg_symbol: LineEdit = $GUI/LLegInput/LineEdit
@onready var rleg_symbol: LineEdit = $GUI/RLegInput/LineEdit
@onready var ascii: Node2D = %Player/ASCII

func _ready() -> void:
	torso_symbol.text_changed.connect(_on_torso_changed)
	head_symbol.text_changed.connect(_on_head_changed)
	larm_symbol.text_changed.connect(_on_larm_changed)
	rarm_symbol.text_changed.connect(_on_rarm_changed)
	lleg_symbol.text_changed.connect(_on_lleg_changed)
	rleg_symbol.text_changed.connect(_on_rleg_changed)

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
