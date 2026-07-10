extends Node2D

func _ready() -> void:
	_set_skintone()
	_set_shirt_color()
	_set_sleave_color()
	_set_pants_color()
	_set_shoe_color()

func _set_skintone() -> void:
	%Head.modulate = Color(CharBodyManager.skin_color)
	%Forearm_Left.modulate = Color(CharBodyManager.skin_color)
	%Forearm_Right.modulate = Color(CharBodyManager.skin_color)
func _set_shirt_color() -> void:
	%Torso.modulate = Color(CharBodyManager.shirt_color)
func _set_sleave_color() -> void:
	%Bicep_Left.modulate = Color(CharBodyManager.sleave_color)
	%Bicep_Right.modulate = Color(CharBodyManager.sleave_color)
func _set_pants_color() -> void:
	%Pelvis.modulate = Color(CharBodyManager.pants_color)
	%Thigh_Left.modulate = Color(CharBodyManager.pants_color)
	%Thigh_Right.modulate = Color(CharBodyManager.pants_color)
	%Shin_Left.modulate = Color(CharBodyManager.pants_color)
	%Shin_Right.modulate = Color(CharBodyManager.pants_color)
func _set_shoe_color() -> void:
	%Foot_Left.modulate = Color(CharBodyManager.shoe_color)
	%Foot_Right.modulate = Color(CharBodyManager.shoe_color)
func _set_head(offset_y: int) -> void:
	%Skull.texture = load(CharBodyManager.head)
	%Skull.position.y = offset_y
func _set_body() -> void:
	%Torso.texture = load(CharBodyManager.body)

func play_idle_animation() -> void:
	%AnimationPlayer.play("idle")
func play_walk_animation() -> void:
	%AnimationPlayer.play("walk")
func play_run_animation() -> void:
	%AnimationPlayer.play("run")
func play_jump_animation() -> void:
	%AnimationPlayer.play("jump")
