extends Node2D

@onready var plr_torso: Label = %Torso/Symbol
@onready var plr_head: Label = %Head/Symbol
@onready var plr_larm: Label = %LArm/Symbol
@onready var plr_rarm: Label = %RArm/Symbol
@onready var plr_lleg: Label = %LLeg/Symbol
@onready var plr_rleg: Label = %RLeg/Symbol

func _process(delta: float) -> void:
	plr_torso.text = CharacterManager.torso
	plr_head.text = CharacterManager.head
	plr_larm.text = CharacterManager.larm
	plr_rarm.text = CharacterManager.rarm
	plr_lleg.text = CharacterManager.lleg
	plr_rleg.text = CharacterManager.rleg

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
func play_splat_animation():
	%AnimationPlayer.play("splat")
func play_platformer_hurt_animation():
	%AnimationPlayer.play("pltfrmr_hurt")
#func play_dead_animation():
#	%AnimationPlayer.play("dead")
func play_blink_animation():
	%AnimationPlayer.play("blink")
func play_pole_slide_animation():
	%AnimationPlayer.play("pole_slide")
func reset_animation():
	%AnimationPlayer.play("RESET")
