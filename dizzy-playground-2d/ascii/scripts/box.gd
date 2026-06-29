extends StaticBody2D

signal was_hit(box_name)
signal has_dollars

func _ready() -> void:
	var face_num = randi_range(1,20)
	if face_num >= 10:
		%Face.text = "$"
	elif face_num >= 5:
		%Face.text = "@"
	elif face_num >= 1:
		%Face.text = "X"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../../../Player":
		if %Face.text == "$":
			%AnimationPlayer.play("bump_dollar")
			has_dollars.emit()
			await get_tree().create_timer(1).timeout
			%Face.text = ""
		else:
			%AnimationPlayer.play("bump")
			was_hit.emit(self.name)
			
