extends Control
signal button_fall(start_state)

func fall_animation():
	%AnimationPlayer.play("button_fall")

func _on_button_button_up() -> void:
	button_fall.emit("start_game")
	fall_animation()
