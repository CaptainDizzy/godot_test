extends Node2D

var chunk_count: int = 4

func _ready() -> void:
	generate_level(chunk_count)

func generate_level(count) -> void:
	for chunk in count:
		pass
