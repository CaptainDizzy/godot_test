extends Node2D

func play_idle_animation() -> void:
	%AnimationPlayer.play("idle")
func play_walk_animation() -> void:
	%AnimationPlayer.play("walk")
func play_run_animation() -> void:
	%AnimationPlayer.play("run")
func play_jump_animation() -> void:
	%AnimationPlayer.play("jump")
