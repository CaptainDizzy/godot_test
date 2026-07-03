extends CharacterBody2D

signal plr_bounce(v: float)
const SPEED = 50
var damage: int = 1
var direction = 1
var is_tossing := true
var tossed := false
var falling := false
var is_dead := false

func _ready() -> void:
	var c1 = floor(randi_range(0,5) + 0.5)
	var c2 = floor(randi_range(0,8) + 0.5)
	if c1 == 0:
		%TosserBody/Body/Hair.text = "\""
		%TosserBody/Body/Hair.position.y = -107
	elif c1 == 1:
		%TosserBody/Body/Hair.text = "\'"
		%TosserBody/Body/Hair.position.y = -107
	elif c1 == 2:
		%TosserBody/Body/Hair.text = "|"
		%TosserBody/Body/Hair.position.y = -107
	elif c1 == 3:
		%TosserBody/Body/Hair.text = "+"
		%TosserBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 4:
		%TosserBody/Body/Hair.text = "*"
		%TosserBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 5:
		%TosserBody/Body/Hair.text = "#"
		%TosserBody/Body/Hair.position.y = -107
	elif c1 == 6:
		%TosserBody/Body/Hair.text = "~"
		%TosserBody/Body/Hair.position.y = -97
	elif c1 == 7:
		%TosserBody/Body/Hair.text = "T"
		%TosserBody/Body/Hair.position.y = -107
	elif c1 == 8:
		%TosserBody/Body/Hair.text = "x"
		%TosserBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 9:
		%TosserBody/Body/Hair.text = "X"
		%TosserBody/Body/Hair.position.y = -107
	elif c1 == 10:
		%TosserBody/Body/Hair.text = "0"
		%TosserBody/Body/Hair.position.y = -107
		
	if c2 == 0:
		%TosserBody/Body/Bod.text = "o"
	elif c2 == 1:
		%TosserBody/Body/Bod.text = "x"
	elif c2 == 2:
		%TosserBody/Body/Bod.text = "e"
	elif c2 == 3:
		%TosserBody/Body/Bod.text = "c"
	elif c2 == 4:
		%TosserBody/Body/Bod.text = "*"
	elif c2 == 5:
		%TosserBody/Body/Bod.text = "w"
	elif c2 == 6:
		%TosserBody/Body/Bod.text = "s"
	elif c2 == 7:
		%TosserBody/Body/Bod.text = "H"
	elif c2 == 8:
		%TosserBody/Body/Bod.text = "|"

func _physics_process(delta: float) -> void:
	# Add the gravity & walk or toss if on the floor.
	if not is_on_floor():
		falling = true
		velocity += get_gravity() * delta
	elif is_on_floor() and not is_dead:
		if not is_tossing:
			velocity.x = move_toward(velocity.x, direction * SPEED, SPEED * 0.1)
			%TosserBody.play_walk_animation()
		elif is_tossing:
			velocity.x = 0
			toss_action()
		
	move_and_slide()
		
	# Check if the enemy collided with a wall | This happens AFTER move_and_slide() because move_and_slide() handles in_on_wall() detection.
	if is_on_wall():
		direction *= -1 # Reverse direction
		self.scale.x *= -1

func toss_action() -> void:
	if not tossed:
		const HAMMER = preload("res://ascii/assets/hammer_toss.tscn")
		var new_hammer = HAMMER.instantiate()
		tossed = true
		%TosserBody.play_toss_animation()
		await get_tree().create_timer(0.75).timeout
		get_parent().add_child(new_hammer)
		new_hammer.global_position.x = self.global_position.x + (80 * direction)
		new_hammer.global_position.y = self.global_position.y - 140
		new_hammer.toss_hammer(direction)
		await get_tree().create_timer(1.25).timeout
		tossed = false
		is_tossing = false

func _on_tossing_timeout() -> void:
	is_tossing = true

func _on_stomped(area: Area2D) -> void:
	if area.is_in_group("player_attacks"):
		plr_bounce.emit(-500)
		get_dead()

func get_dead() -> void:
	is_dead = true
	%TosserBody.get_stomped()
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
		print(dir)
		area.get_parent().take_damage(damage, dir)

func _on_detect_standing_body(body: Node2D) -> void:
	var node_on = get_node("%" + body.name)
	if not is_dead:
		node_on.is_stood_on(self.name)
func _on_detect_leaving_body(body: Node2D) -> void:
	var node_left = get_node("%" + body.name)
	if not is_dead:
		node_left.is_no_longer_stood_on()
