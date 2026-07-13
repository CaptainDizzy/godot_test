extends Node2D

signal plr_bounce(b: float)

func _on_flyer_plr_bounce(v: float) -> void:
	plr_bounce.emit(v)
