extends CharacterBody2D

signal plr_bounce(v: float)
const SPEED = 100
var damage: int = 1
var direction = 1
var falling := false
var is_dead := false

func _ready() -> void:
	var c1 = floor(randi_range(0,5) + 0.5)
	var c2 = floor(randi_range(0,8) + 0.5)
	if c1 == 0:
		%CrawlerBody/Body/Hair.text = "\""
		%CrawlerBody/Body/Hair.position.y = -107
	elif c1 == 1:
		%CrawlerBody/Body/Hair.text = "\'"
		%CrawlerBody/Body/Hair.position.y = -107
	elif c1 == 2:
		%CrawlerBody/Body/Hair.text = "|"
		%CrawlerBody/Body/Hair.position.y = -107
	elif c1 == 3:
		%CrawlerBody/Body/Hair.text = "+"
		%CrawlerBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 4:
		%CrawlerBody/Body/Hair.text = "*"
		%CrawlerBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 5:
		%CrawlerBody/Body/Hair.text = "#"
		%CrawlerBody/Body/Hair.position.y = -107
	elif c1 == 6:
		%CrawlerBody/Body/Hair.text = "~"
		%CrawlerBody/Body/Hair.position.y = -97
	elif c1 == 7:
		%CrawlerBody/Body/Hair.text = "T"
		%CrawlerBody/Body/Hair.position.y = -107
	elif c1 == 8:
		%CrawlerBody/Body/Hair.text = "x"
		%CrawlerBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 9:
		%CrawlerBody/Body/Hair.text = "X"
		%CrawlerBody/Body/Hair.position.y = -107
	elif c1 == 10:
		%CrawlerBody/Body/Hair.text = "0"
		%CrawlerBody/Body/Hair.position.y = -107
		
	if c2 == 0:
		%CrawlerBody/Body/Bod.text = "o"
	elif c2 == 1:
		%CrawlerBody/Body/Bod.text = "x"
	elif c2 == 2:
		%CrawlerBody/Body/Bod.text = "e"
	elif c2 == 3:
		%CrawlerBody/Body/Bod.text = "c"
	elif c2 == 4:
		%CrawlerBody/Body/Bod.text = "*"
	elif c2 == 5:
		%CrawlerBody/Body/Bod.text = "w"
	elif c2 == 6:
		%CrawlerBody/Body/Bod.text = "s"
	elif c2 == 7:
		%CrawlerBody/Body/Bod.text = "H"
	elif c2 == 8:
		%CrawlerBody/Body/Bod.text = "|"

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
		self.scale.x *= -1

func _on_stomped(area: Area2D) -> void:
	if area.is_in_group("player_attacks"):
		is_dead = true
		%CrawlerBody.get_stomped()
		plr_bounce.emit(-500)
		%StompBox.queue_free()
		%DamageBox.queue_free()
		set_collision_layer_value(2,false)
		set_collision_mask_value(1,false)
		await get_tree().create_timer(1.25).timeout
		queue_free()

func _on_damage_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtbox"):
		var dir: int
		if self.global_position.x - area.global_position.x > 0:
			dir = -1
		else:
			dir = 1
		print(damage)
		area.get_parent().take_damage(damage, dir)
