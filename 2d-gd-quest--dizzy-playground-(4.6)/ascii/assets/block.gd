extends StaticBody2D

func _on_bonked(body: Node2D) -> void:
	if body.is_in_group("player"):
		%AnimationPlayer.play("break")
		await get_tree().create_timer(0.5).timeout
		queue_free()
