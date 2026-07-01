extends StaticBody2D

func _on_bonked(area: Area2D) -> void:
	if area.is_in_group("player"):
		%AnimationPlayer.play("break")
		await get_tree().create_timer(0.5).timeout
		queue_free()
