extends Node2D

@onready var head_char: LineEdit = $GUI/HeadInput/LineEdit
@onready var torso_char: LineEdit = $GUI/TorsoInput/LineEdit
@onready var larm_char: LineEdit = $GUI/LArmInput/LineEdit
@onready var rarm_char: LineEdit = $GUI/RArmInput/LineEdit
@onready var lleg_char: LineEdit = $GUI/LLegInput/LineEdit
@onready var rleg_char: LineEdit = $GUI/RLegInput/LineEdit
@onready var plr_head: Label = $Player/ASCII/Head/Symbol
@onready var plr_torso: Label = $Player/ASCII/Torso/Symbol
@onready var plr_larm: Label = $Player/ASCII/LArm/Symbol
@onready var plr_rarm: Label = $Player/ASCII/RArm/Symbol
@onready var plr_lleg: Label = $Player/ASCII/LLeg/Symbol
@onready var plr_rleg: Label = $Player/ASCII/RLeg/Symbol

func _ready() -> void:
	head_char.text_changed.connect(_on_head_changed)

func _on_head_changed() -> void:
	$Player/ASCII/Head/Symbol.text = $GUI/HeadInput/LineEdit.text
