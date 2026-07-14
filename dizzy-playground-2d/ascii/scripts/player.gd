extends CharacterBody2D

signal health_depleted
signal game_state(state)
signal platformer_landing

var heart_string: String = ""
var dollars: float = 0
var is_dead = false
var death_anim = false
var state: String = "create_char"
var last_state: String = ""

const SPEED = 250.0
const JUMP_V = -1000
var is_jumping = false
var falling = false
var fall_anim = false
var was_on_floor = true
var first_landing = true
var hurt = false
var speed_multiplier = 1
var prev_multi
var hurt_blink := false
var is_blinking = true
var flag_reached = false
var sliding_pole = false
var blink_time: float = 20
var blink_number: int = 4 #This needs to be an even number or the player will end invisible
var attack_direction: int = 0


func _physics_process(delta: float) -> void:
	%DollarCount.text = str(dollars)
	heart_string = ""
	for i in range(CharacterManager.health):
		heart_string += "♥"
	%Hearts.text = heart_string
	
	if state == "create_char":
		%ASCII.play_idle_animation()
	elif state == "intro_screens":
		var sprint_multi: float = 1
		if Input.is_action_pressed("sprint"):
			sprint_multi = 2
		speed_multiplier = %Player.scale.x * sprint_multi
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
			if Input.is_action_pressed("sprint"):
				%ASCII.play_run_animation()
			else:
				%ASCII.play_walk_animation()
		elif velocity.length() <= 0.0 && not is_dead:
			%ASCII.play_idle_animation()
		elif is_dead == true && not death_anim:
			%ASCII.play_dead_animation()
			death_anim = true
		move_and_slide()
		
	elif state == "platformer":		
		if Input.is_action_pressed("sprint"):
			speed_multiplier = move_toward(speed_multiplier, 3, 0.1)
		else:
			speed_multiplier = move_toward(speed_multiplier, 1, 0.1)
		
		if not flag_reached: # Only allow player control when it's the the end of the level for exit animation.
			# Add the gravity.
			if not is_on_floor():
				falling = true
				velocity += get_gravity() * delta
				
			# Get the input direction and handle the movement/deceleration.
			var direction := Input.get_axis("move_left", "move_right")

			# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				prev_multi = speed_multiplier
				is_jumping = true
				%ASCII.play_jump_animation()
				velocity.y = JUMP_V
			
			if not is_on_floor() and is_jumping and not first_landing:
				velocity.x = move_toward(velocity.x, direction * SPEED * prev_multi, SPEED * 0.1)
			
			# Ground movement 
			if is_on_floor() and not is_jumping and not first_landing and not hurt:
				if direction != 0:
					velocity.x = move_toward(velocity.x, direction * SPEED * speed_multiplier, SPEED * 0.25)
					if speed_multiplier > 2:
						%ASCII.play_run_animation()
					else:
						%ASCII.play_walk_animation()
				else:
					velocity.x = move_toward(velocity.x, 0, SPEED * 0.25)
					%ASCII.play_idle_animation()
			
			if not fall_anim and falling:
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
			
		else:
			if sliding_pole: # Track if the player is sliding so this chunk doesn't run again after the player touches the floor
				velocity.x = 0
				%ASCII.play_pole_slide_animation()
				velocity.y += 500 * delta
			if is_on_floor():
				sliding_pole = false # Turn if off just before the await so the above chunk doesn't run during the await and override the animation
				await get_tree().create_timer(0.5).timeout
				%ASCII.play_run_animation()
				velocity.x += SPEED * 3 * delta
			move_and_slide()
	
	elif state == "shmup":
		pass 
	elif state == "adventure":
		pass

	if state != "platformer":
		if last_state != state:
			print(str(last_state) + " " + str(state))
			first_landing = true
			fall_anim = false
	

func take_damage(damage: int, direction: int) -> void:
	CharacterManager.health -= damage
	hurt = true
	if direction == 0:
		%ASCII.play_blink_animation()
		await get_tree().create_timer(0.51).timeout
	else:
		velocity.y = -250
		velocity.x = attack_direction * 250
		%ASCII.play_platformer_hurt_animation()
		await get_tree().create_timer(0.33).timeout
	move_and_slide()
	hurt = false

func _on_landing() -> void:
	if first_landing:
		velocity.x = 0
		%ASCII.play_splat_animation()
		await get_tree().create_timer(1.5).timeout
		first_landing = false
		platformer_landing.emit()
		falling = false
		is_jumping = false
	else:
		first_landing = false
		falling = false
		is_jumping = false

func change_game_state(new_state: String):
	last_state = state
	state = new_state
	game_state.emit(state)

func _on_platformer_bounce_player(v: float) -> void:
	%ASCII.play_jump_animation()
	is_jumping = true
	velocity.y = v
	move_and_slide()

func _on_add_dollars(d: float) -> void:
	dollars += d
	
func _on_fake_button_fall(start_state: String) -> void:
	change_game_state(start_state)

func _on_name_changed(new_text: String) -> void:
	CharacterManager.char_name = new_text

func _on_platformer_screen_platform_state(new_state: String) -> void:
	change_game_state(new_state)

func _on_fork_screen_intro_state(new_state: String) -> void:
	change_game_state(new_state)

func _on_platformer_screen_flag_down(flag) -> void:
	global_position.x = flag.global_position.x
	sliding_pole = true
	flag_reached = true

func _on_platformer_level_completed() -> void:
	pass # Anything that needs to update or do something after clearing a level
