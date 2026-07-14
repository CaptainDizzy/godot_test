extends Label

var heart_string: String = ""

func _process(delta: float) -> void:
	heart_string = ""
	for i in range(CharacterManager.health):
		heart_string += "♥"
	text = heart_string
