extends CharacterBody2D

signal plr_bounce(v: float)

func _on_stomped(body: Node2D) -> void:
	if body == $"../../../Player":
		%CrawlerBody.get_stomped()
		plr_bounce.emit(-500)
		await get_tree().create_timer(1.25).timeout
		queue_free()
