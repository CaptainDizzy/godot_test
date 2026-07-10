extends Button

signal picked_head(h: String)

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	picked_head.emit("res://imgs/head_base.svg")
