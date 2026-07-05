extends Button

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	%PathTreePreview.visible = true

func _on_mouse_exited() -> void:
	%PathTreePreview.visible = false

func _pressed() -> void:
	%DizzyTransitions.visible = true
	%DizzyTransitions.transition_out_wipe_left()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://path_tree/path_tree.tscn")
