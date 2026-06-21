extends CharacterBody2D

signal health_depleted

var health = 100.0
var is_dead = false
var death_anim = false


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if is_dead:
		velocity = direction * 0
	else:
		velocity = direction * 600
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
	
