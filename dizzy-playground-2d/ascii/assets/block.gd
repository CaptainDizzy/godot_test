extends StaticBody2D

var is_below: String = ""

func is_stood_on(by: String) -> void:
	is_below = by
func is_no_longer_stood_on() -> void:
	is_below = ""

func _on_bonked(body: Node2D) -> void:
	if body.is_in_group("player"):
		if is_below:
			var standing_node = get_node("../../Mobs/" + is_below)
			standing_node.get_dead()
		
		%AnimationPlayer.play("break")
		await get_tree().create_timer(0.5).timeout
		queue_free()
