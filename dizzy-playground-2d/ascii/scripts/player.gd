extends CharacterBody2D

signal health_depleted
signal game_state(state)
signal platformer_landing

var health = 100.0
var is_dead = false
var death_anim = false
var state: String = "platformer"
var last_state: String = ""
var char_name: String = "ASCII"

const SPEED = 250.0
const JUMP_V = -800
var is_jumping = false
var falling = false
var fall_anim = false
var was_on_floor = true
var first_landing = true
var speed_multiplier = 1


func _physics_process(delta: float) -> void:
	speed_multiplier = %Player.scale.x
	if state == "create_char":
		%ASCII.play_idle_animation()
	elif state == "start_game":
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if is_dead:
			velocity = direction * 0
		else:
			velocity = direction * SPEED * speed_multiplier
		if direction.x < 0:
			%ASCII.scale.x = -1
		elif direction.x > 0:
			%ASCII.scale.x = 1
		
		if velocity.length() > 0.0 && not is_dead:
			%ASCII.play_walk_animation()
		if velocity.length() <= 0.0 && not is_dead:
			%ASCII.play_idle_animation()
		if is_dead == true && not death_anim:
			%ASCII.play_dead_animation()
			death_anim = true
		move_and_slide()
			
		
	elif state == "platformer":
		%Player.scale.x = 0.66
		%Player.scale.y = 0.66
		# Add the gravity.
		if not is_on_floor():
			falling = true
			velocity += get_gravity() * delta
			
		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("move_left", "move_right")

		# Handle jump.
		if Input.is_action_pressed("jump") and is_on_floor():
			is_jumping = true
			velocity.x = move_toward(velocity.x, 0, SPEED * speed_multiplier)
			%ASCII.play_jump_animation()
			velocity.y = JUMP_V
			if Input.is_action_pressed("sprint"):
				velocity.x = direction * (SPEED * speed_multiplier * 2.5)
			else:
				velocity.x = direction * (SPEED * speed_multiplier * 1.5)
			
		elif Input.is_action_just_released("jump"):
			pass #%ASCII.play_falling_animation()
			
		# Ground movement (only when not charging a jump)
		elif is_on_floor() and not is_jumping and not first_landing:
			if Input.is_action_pressed("sprint") and direction != 0:
				velocity.x = direction * (SPEED * speed_multiplier * 2)
				%ASCII.play_run_animation()
			elif direction != 0:
				velocity.x = direction * SPEED * speed_multiplier
				%ASCII.play_walk_animation()
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED * speed_multiplier)
				%ASCII.play_idle_animation()
			
		if not fall_anim and not is_jumping:
			%ASCII.play_falling_animation()
			fall_anim = true
		
		if direction < 0:
			%ASCII.scale.x = -1
		if direction > 0:
			%ASCII.scale.x = 1
		
		move_and_slide()
		
		var on_floor := is_on_floor()     # 1. snapshot THIS frame
		if on_floor and not was_on_floor: # 2. check the transition
			_on_landing()                 # 3. react
		was_on_floor = on_floor           # 4. remember for NEXT frame
		
	elif state == "shmup":
		pass 
	elif state == "adventure":
		pass 

func _on_landing() -> void:
	if first_landing:
		%ASCII.play_splat_animation()
		await get_tree().create_timer(1.5).timeout
		platformer_landing.emit()
		first_landing = false
	fall_anim = false
	is_jumping = false

func _on_fake_button_fall(start_state: String) -> void:
	change_game_state(start_state)

func _on_name_changed(new_text: String) -> void:
	char_name = new_text
	print(char_name)

func _on_platformer_screen_platform_state() -> void:
	change_game_state("platformer")

func change_game_state(new_state: String):
	last_state = state
	state = new_state
	game_state.emit(state)
