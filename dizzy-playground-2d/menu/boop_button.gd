extends Button

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	%ASCIIPreview.visible = true

func _on_mouse_exited() -> void:
	%ASCIIPreview.visible = false

func _pressed() -> void:
	%DizzyTransitions.visible = true
	%DizzyTransitions.transition_out_wipe_left()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://boop_game/game_boop.tscn")
