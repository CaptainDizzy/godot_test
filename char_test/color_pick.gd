extends Control

signal color_picked(c: Color)

func _ready() -> void:
	close_picker()
	for color in %Options.get_children():
		color.get_child(0).pick_color.connect(_set_color)

func _on_color_button_pressed() -> void:
	if %Options.visible == false:
		open_picker()
	else:
		close_picker()

func _set_color(c) -> void:
	%SelectedColor.color = c
	color_picked.emit(c)
	close_picker()

func close_picker() -> void:
	%Options.visible = false
	custom_minimum_size.y = 60

func open_picker() -> void:
	%Options.visible = true
	if %Options.get_children().size() <= 9:
		custom_minimum_size.y = 60
	else:
		custom_minimum_size.y = 120
