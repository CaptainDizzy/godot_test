extends CharacterBody2D

signal plr_bounce(v: float)
const SPEED = 100
var damage: int = 1
var direction = 1
var falling := false
var is_dead := false

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		falling = true
		velocity += get_gravity() * delta
	elif is_on_floor() and not is_dead:
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED * 0.1)
		%CrawlerBody.play_walk_animation()

	move_and_slide()
	
	# Check if the enemy collided with a wall | This happens AFTER move_and_slide() because move_and_slide() handles in_on_wall() detection.
	if is_on_wall():
		direction *= -1 # Reverse direction

func _on_stomped(area: Area2D) -> void:
	if area.is_in_group("player_attacks"):
		is_dead = true
		%CrawlerBody.get_stomped()
		plr_bounce.emit(-500)
		await get_tree().create_timer(1.25).timeout
		queue_free()

func _on_damage_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtbox"):
		var dir: int
		if self.global_position.x - area.global_position.x > 0:
			dir = -1
		else:
			dir = 1
		area.get_parent().take_damage(damage, dir)
