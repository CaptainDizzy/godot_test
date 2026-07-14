extends Node2D

signal end_level(flag: Node2D)

func play_flagdrop_animation() -> void:
	%AnimationPlayer.play("go_down")

func _on_player_touch(body: Node2D) -> void:
	if body.is_in_group("player"):
		end_level.emit(self)
