extends StaticBody2D

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
func is_no_longer_stood_on() -> void:
	is_below = ""

func _on_bonked(body: Node2D) -> void:
	if body.is_in_group("player"):
		var is_alive = get_node_or_null("../../Mobs/" + is_below) 
		if is_alive and is_below :
			var standing_node = get_node("../../Mobs/" + is_below)
			standing_node.get_dead()
			
		if %Face.text == "$":
			%AnimationPlayer.play("bump_dollar")
			has_dollars.emit()
			await get_tree().create_timer(1).timeout
			%Face.text = ""
		else:
			%AnimationPlayer.play("bump")
			%Face.text = ""
		
