extends Node2D

@onready var plr_torso: Label = %Torso/Symbol
@onready var plr_head: Label = %Head/Symbol
@onready var plr_larm: Label = %LArm/Symbol
@onready var plr_rarm: Label = %RArm/Symbol
@onready var plr_lleg: Label = %LLeg/Symbol
@onready var plr_rleg: Label = %RLeg/Symbol

func set_torso_symbol(symbol: String) -> void:
	plr_torso.text = symbol
func set_head_symbol(symbol: String) -> void:
	plr_head.text = symbol
func set_larm_symbol(symbol: String) -> void:
	plr_larm.text = symbol
func set_rarm_symbol(symbol: String) -> void:
	plr_rarm.text = symbol
func set_lleg_symbol(symbol: String) -> void:
	plr_lleg.text = symbol
func set_rleg_symbol(symbol: String) -> void:
	plr_rleg.text = symbol

func play_idle_animation():
	%AnimationPlayer.play("idle")
func play_walk_animation():
	%AnimationPlayer.play("walk")
func play_run_animation():
	%AnimationPlayer.play("run")
func play_ready_jump_animation():
	%AnimationPlayer.play("ready_jump")
func play_jump_animation():
	%AnimationPlayer.play("jump")
func play_falling_animation():
	%AnimationPlayer.play("falling")
func play_dead_animation():
	%AnimationPlayer.play("dead")
func reset_animation():
	%AnimationPlayer.play("RESET")
