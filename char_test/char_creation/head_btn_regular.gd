extends Button

signal picked_head(h: String, offset_y: int)

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	picked_head.emit("res://imgs/head_medium.svg", -5)
