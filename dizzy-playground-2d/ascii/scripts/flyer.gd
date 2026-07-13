extends CharacterBody2D

@onready var path: Path2D = $"../Path2D"
@onready var path_follow: PathFollow2D = $"../Path2D/PathFollow2D"

signal plr_bounce(v: float)
const SPEED = 200
var damage: int = 1
var direction = 1
var falling := false
var is_dead := false

func _ready() -> void:
	var c1 = floor(randi_range(0,5) + 0.5)
	var c2 = floor(randi_range(0,8) + 0.5)
	if c1 == 0:
		%FlyerBody/Body/Hair.text = "\""
		%FlyerBody/Body/Hair.position.y = -107
	elif c1 == 1:
		%FlyerBody/Body/Hair.text = "\'"
		%FlyerBody/Body/Hair.position.y = -107
	elif c1 == 2:
		%FlyerBody/Body/Hair.text = "|"
		%FlyerBody/Body/Hair.position.y = -107
	elif c1 == 3:
		%FlyerBody/Body/Hair.text = "+"
		%FlyerBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 4:
		%FlyerBody/Body/Hair.text = "*"
		%FlyerBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 5:
		%FlyerBody/Body/Hair.text = "#"
		%FlyerBody/Body/Hair.position.y = -107
	elif c1 == 6:
		%FlyerBody/Body/Hair.text = "~"
		%FlyerBody/Body/Hair.position.y = -97
	elif c1 == 7:
		%FlyerBody/Body/Hair.text = "T"
		%FlyerBody/Body/Hair.position.y = -107
	elif c1 == 8:
		%FlyerBody/Body/Hair.text = "x"
		%FlyerBody/Body/Hair.position.y = -107
		%StompBox/CBox.position.y = -100
	elif c1 == 9:
		%FlyerBody/Body/Hair.text = "X"
		%FlyerBody/Body/Hair.position.y = -107
	elif c1 == 10:
		%FlyerBody/Body/Hair.text = "0"
		%FlyerBody/Body/Hair.position.y = -107
		
	if c2 == 0:
		%FlyerBody/Body/Bod.text = "o"
	elif c2 == 1:
		%FlyerBody/Body/Bod.text = "x"
	elif c2 == 2:
		%FlyerBody/Body/Bod.text = "e"
	elif c2 == 3:
		%FlyerBody/Body/Bod.text = "c"
	elif c2 == 4:
		%FlyerBody/Body/Bod.text = "*"
	elif c2 == 5:
		%FlyerBody/Body/Bod.text = "w"
	elif c2 == 6:
		%FlyerBody/Body/Bod.text = "s"
	elif c2 == 7:
		%FlyerBody/Body/Bod.text = "H"
	elif c2 == 8:
		%FlyerBody/Body/Bod.text = "|"

func _physics_process(delta: float) -> void:
	var path_length: float = path.curve.get_baked_length()
	
	path_follow.progress += SPEED * delta * direction
	
	if path_follow.progress >= path_length:
		path_follow.progress = path_length
		direction = -1
	elif path_follow.progress <= 0.0:
		path_follow.progress = 0.0
		direction = 1
	
	var target_position: Vector2 = path_follow.global_position
	var move_direction: Vector2 = (target_position - global_position)

	if move_direction.length() > 4.0:
		velocity = move_direction.normalized() * SPEED
	else:
		velocity = Vector2.ZERO
	
	if not is_dead:
		%FlyerBody.play_fly_animation()
	
	move_and_slide()

func _on_stomped(area: Area2D) -> void:
	if area.is_in_group("player_attacks"):
		plr_bounce.emit(-750)
		get_dead()

func get_dead() -> void:
	if not is_dead:
		is_dead = true
		%FlyerBody.get_stomped()
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
		area.get_parent().take_damage(damage, dir)

func _on_detect_standing_body(body: Node2D) -> void:
	if body.is_in_group("bumpable") and not is_dead:
		var node_on = get_node("%" + body.name)
		node_on.is_stood_on(self.name)
func _on_detect_leaving_body(body: Node2D) -> void:
	if body.is_in_group("bumpable") and not is_dead:
		var node_left = get_node("%" + body.name)
		node_left.is_no_longer_stood_on()
