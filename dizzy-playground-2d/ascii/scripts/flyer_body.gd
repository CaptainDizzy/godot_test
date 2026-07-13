extends Node2D

func get_stomped() -> void:
	%AnimationPlayer.play("stomped")
func play_walk_animation() -> void:
	%AnimationPlayer.play("walk")
func play_fly_animation() -> void:
	%AnimationPlayer.play("fly")
