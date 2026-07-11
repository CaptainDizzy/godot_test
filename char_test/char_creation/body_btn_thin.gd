extends Button

signal picked_body(b: String)

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	picked_body.emit("res://imgs/torso_thin.svg")
