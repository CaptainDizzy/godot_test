extends Control
signal button_fall(start_state)

func fall_animation():
	%AnimationPlayer.play("button_fall")

func _on_button_button_up() -> void:
	button_fall.emit("intro_screens")
	fall_animation()
	await %AnimationPlayer.animation_finished
	%Title.text = "Uh oh..."
