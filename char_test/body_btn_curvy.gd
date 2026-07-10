extends Button

signal picked_body(b: String)

func _on_pressed() -> void:
	picked_body.emit("res://imgs/torso_f.svg")
