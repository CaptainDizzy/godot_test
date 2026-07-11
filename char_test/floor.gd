extends Area2D

signal is_inside(i: bool)

func _process(delta: float) -> void:
	var areas: Array[Area2D] = get_overlapping_areas()
	if areas.size() > 0:
		for area in areas:
			if area.name == "Feet":
				is_inside.emit(true)
			else:
				is_inside.emit(false)
	else:
		is_inside.emit(false)
