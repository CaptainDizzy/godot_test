extends Button

signal pick_color(c: Color)

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var c = get_parent().color
	pick_color.emit(c)
