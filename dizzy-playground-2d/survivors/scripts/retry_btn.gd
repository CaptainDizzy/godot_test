extends Button

func _pressed() -> void:
	%DizzyTransitions.visible = true
	%DizzyTransitions.transition_out_wipe_left()
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()
