extends Node2D

var mob_spawning = true

func _ready() -> void:
	%DizzyTransitions.visible = true
	%DizzyTransitions.transition_in_wipe_right()
	await get_tree().create_timer(1).timeout
	%DizzyTransitions.visible = false

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout() -> void:
	if mob_spawning == true:
		spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	mob_spawning = false
	#get_tree().paused = true
