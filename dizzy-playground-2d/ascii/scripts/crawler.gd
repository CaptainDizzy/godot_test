extends CharacterBody2D

func _on_stomped(body: Node2D) -> void:
	if body == $"../../../Player":
		%CrawlerBody.get_stomped()
		await get_tree().create_timer(1.25).timeout
		queue_free()
