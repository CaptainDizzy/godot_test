extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	%DizzyTransitions.visible = true
	%DizzyTransitions.transition_out_wipe_left()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://game.tscn")
