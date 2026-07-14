extends LineEdit

func _on_text_changed(new_text: String) -> void:
	CharacterManager.larm = new_text
