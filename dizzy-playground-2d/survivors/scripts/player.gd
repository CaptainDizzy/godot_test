extends CharacterBody2D

signal health_depleted

var health = 100.0
var is_dead = false
var death_anim = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if is_dead == true:
		velocity = direction * 0
	else:
		velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0 && is_dead == false:
		%HappyBoo.play_walk_animation()
	if velocity.length() <= 0.0 && is_dead == false:
		%HappyBoo.play_idle_animation()
	if is_dead == true && death_anim == false:
		%HappyBoo.play_dead_animation()
		death_anim = true
	
	const DAMAGE_RATE = 15
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		
		if health <= 0.0:
			is_dead = true
			health_depleted.emit()

func play_dead() -> void:
	%HappyBoo.play_dead_animation()
