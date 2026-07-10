extends Button

signal picked_head(h: String)

func _on_pressed() -> void:
	picked_head.emit("res://imgs/head_small.svg")
