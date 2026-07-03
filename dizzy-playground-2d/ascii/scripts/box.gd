extends StaticBody2D

signal was_hit(box_name)
signal has_dollars
var is_below: String = ""

func _ready() -> void:
	var face_num = randi_range(1,20)
	if face_num >= 10:
		%Face.text = "$"
	elif face_num >= 5:
		%Face.text = "@"
	elif face_num >= 1:
		%Face.text = "%"

func is_stood_on(by: String) -> void:
	is_below = by
	print(str(is_below) + " is on " + str(self.name))

func _on_bonked(body: Node2D) -> void:
	if body.is_in_group("player"):
		if %Face.text == "$":
			%AnimationPlayer.play("bump_dollar")
			has_dollars.emit()
			await get_tree().create_timer(1).timeout
			%Face.text = ""
		else:
			%AnimationPlayer.play("bump")
			%Face.text = ""
			was_hit.emit(self.name)
