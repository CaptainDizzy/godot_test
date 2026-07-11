extends CharacterBody2D

const JUMP_V = -400
const SPEED = 150
var speed_multiplier: float = 1
var prev_multi: float
var standing_y: float
var prev_position: Vector2
var inside_floor_bounds: bool = true
var grounded: bool = true
var on_ground: bool = true
var was_on_ground: bool
var falling: bool = false
var is_jumping: bool = false
var hurt: bool = false
var fall_anim: bool = false

func _ready() -> void:
	standing_y = position.y

func _physics_process(delta: float) -> void:
	prev_position = position
	
	if Input.is_action_pressed("sprint"):
		speed_multiplier = move_toward(speed_multiplier, 3, 0.1)
	else:
		speed_multiplier = move_toward(speed_multiplier, 1, 0.1)
	
	# Add the gravity.
	if not is_on_ground():
		falling = true
		velocity += get_gravity() * delta
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	var depth
	if Input.is_action_pressed("move_up"):
		depth = -1
	elif Input.is_action_pressed("move_down"):
		depth = 1
	else:
		depth = 0
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_ground():
		prev_multi = speed_multiplier
		is_jumping = true
		grounded = false
		standing_y = position.y
		%CharBody.play_jump_animation()
		#await get_tree().create_timer(0.25).timeout
		velocity.y = JUMP_V
	
	if not is_on_ground() and is_jumping:
		velocity.x = move_toward(velocity.x, direction * SPEED * prev_multi, SPEED * 0.1)
	
	# Ground movement 
	if is_on_ground() and not is_jumping and not hurt:
		if direction != 0 or depth != 0:
			velocity.x = move_toward(velocity.x, direction * SPEED * speed_multiplier, SPEED * speed_multiplier)
			velocity.y = move_toward(velocity.y, depth * (SPEED * 0.66) * speed_multiplier, SPEED * speed_multiplier)
			standing_y = position.y
			if speed_multiplier > 2:
				%CharBody.play_run_animation()
			else:
				%CharBody.play_walk_animation()
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * 0.25)
			velocity.y = move_toward(velocity.y, 0, SPEED * 0.25)
			%CharBody.play_idle_animation()
	
	if not fall_anim and falling:
		#%CharBody.play_falling_animation()
		fall_anim = true
	
	if direction < 0:
		%CharBody.scale.x = -1
	if direction > 0:
		%CharBody.scale.x = 1
	
	move_and_slide() 
	#move_and_slide() is the moment the character actually exists in the world for that frame. 
	#Everything before it is planning, everything after it is reacting to what actually happened.
	
	if not is_on_ground() and position.y >= standing_y:
		grounded = true
		is_jumping = false
		position.y = standing_y
	
	on_ground = is_on_ground()          # 1. snapshot THIS frame
	if on_ground and not was_on_ground: # 2. check the transition
		_on_landing()                   # 3. react
	was_on_ground = on_ground           # 4. remember for NEXT frame
	
	#print(grounded)

func is_on_ground() -> bool:
	if grounded and inside_floor_bounds:
		return true
	else:
		return false

func _on_landing() -> void:
	falling = false
	is_jumping = false

func _is_inside_floor(i: bool) -> void:
	inside_floor_bounds = i

func _on_floor_area_exited(area: Area2D) -> void:
	if area == %Char/Feet:
		standing_y = prev_position.y
		position.y = standing_y
