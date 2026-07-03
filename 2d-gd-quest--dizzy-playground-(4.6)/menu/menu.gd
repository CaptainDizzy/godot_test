extends Node2D

func _ready() -> void:
	%DizzyTransitions.visible = true
	%DizzyTransitions.transition_in_wipe_right()
	await get_tree().create_timer(1).timeout
	%DizzyTransitions.visible = false
