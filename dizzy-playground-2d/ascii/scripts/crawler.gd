extends CharacterBody2D

signal plr_bounce(v: float)

var damage: int = 1

func _on_stomped(area: Area2D) -> void:
	if area == $"../../../Player/StompBox":
		%CrawlerBody.get_stomped()
		plr_bounce.emit(-500)
		await get_tree().create_timer(1.25).timeout
		queue_free()

func _on_damage_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtbox"):
		var direction: int
		if self.global_position.x - area.global_position.x > 0:
			direction = -1
		else:
			direction = 1
		area.get_parent().take_damage(damage, direction)
