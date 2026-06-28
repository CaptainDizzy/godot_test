extends StaticBody2D

signal was_hit(box_name)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../../../Player":
		%AnimationPlayer.play("bump")
		was_hit.emit(self.name)
