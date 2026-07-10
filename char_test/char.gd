extends CharacterBody2D

const JUMP_V = -400
const SPEED = 200
var speed_multiplier: float = 1
var prev_multi: float
var falling: bool = false
var is_jumping: bool = false
var hurt: bool = false
var fall_anim: bool = false
var was_on_floor

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("sprint"):
		speed_multiplier = move_toward(speed_multiplier, 3, 0.1)
	else:
		speed_multiplier = move_toward(speed_multiplier, 1, 0.1)

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
		%CharBody.play_jump_animation()
		#await get_tree().create_timer(0.25).timeout
		velocity.y = JUMP_V

	if not is_on_floor() and is_jumping:
		velocity.x = move_toward(velocity.x, direction * SPEED * prev_multi, SPEED * 0.1)

	# Ground movement 
	if is_on_floor() and not is_jumping and not hurt:
		if direction != 0:
			velocity.x = move_toward(velocity.x, direction * SPEED * speed_multiplier, SPEED * speed_multiplier)
			if speed_multiplier > 2:
				%CharBody.play_run_animation()
			else:
				%CharBody.play_walk_animation()
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * 0.25)
			%CharBody.play_idle_animation()

	if not fall_anim and falling:
		#%CharBody.play_falling_animation()
		fall_anim = true

	if direction < 0:
		%CharBody.scale.x = -1
	if direction > 0:
		%CharBody.scale.x = 1

	move_and_slide()

	var on_floor := is_on_floor()     # 1. snapshot THIS frame
	if on_floor and not was_on_floor: # 2. check the transition
		_on_landing()                 # 3. react
	was_on_floor = on_floor           # 4. remember for NEXT frame

func _on_landing() -> void:
	falling = false
	is_jumping = false
