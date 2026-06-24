extends CharacterBody2D

signal health_depleted
signal game_state(state)

var health = 100.0
var is_dead = false
var death_anim = false
var state: String = "create_char"
var last_state: String = ""
var char_name: String = ""

const SPEED = 250.0
var speed_multiplier = 1


func _physics_process(delta: float) -> void:
	if state != "create_char":
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if is_dead:
			velocity = direction * 0
		else:
			velocity = direction * SPEED * speed_multiplier
		if direction.x < 0:
			%ASCII.scale.x = -1
		elif direction.x > 0:
			%ASCII.scale.x = 1
		
	move_and_slide()
	
	if velocity.length() > 0.0 && not is_dead:
		%ASCII.play_walk_animation()
	if velocity.length() <= 0.0 && not is_dead:
		%ASCII.play_idle_animation()
	if is_dead == true && not death_anim:
		%ASCII.play_dead_animation()
		death_anim = true

func _on_fake_button_fall(start_state: String) -> void:
	change_game_state(start_state)

func _on_name_changed(new_text: String) -> void:
	char_name = new_text
	print(char_name)

func _on_title_screen() -> void:
	speed_multiplier = 0.66

func change_game_state(new_state: String):
	last_state = state
	state = new_state
	game_state.emit(state)
