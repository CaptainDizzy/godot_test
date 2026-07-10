extends Node2D

func _on_skintone_picked(c: Color) -> void:
	CharBodyManager.skin_color = c
	%CharBody._set_skintone()

func _on_shirt_color_picked(c: Color) -> void:
	CharBodyManager.shirt_color = c
	%CharBody._set_shirt_color()

func _on_sleave_color_picked(c: Color) -> void:
	CharBodyManager.sleave_color = c
	%CharBody._set_sleave_color()

func _on_pants_color_picked(c: Color) -> void:
	CharBodyManager.pants_color = c
	%CharBody._set_pants_color()

func _on_shoe_color_picked(c: Color) -> void:
	CharBodyManager.shoe_color = c
	%CharBody._set_shoe_color()
