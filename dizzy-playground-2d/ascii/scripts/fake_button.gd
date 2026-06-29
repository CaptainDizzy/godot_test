extends Control

signal button_fall(start_state)
signal start_music(confirm)

func fall_animation():
	%AnimationPlayer.play("button_fall")

func _on_button_button_up() -> void:
	button_fall.emit("intro_screens")
	start_music.emit(true)
	fall_animation()
	await %AnimationPlayer.animation_finished
	%Title.text = "Uh oh..."
