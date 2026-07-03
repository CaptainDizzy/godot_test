extends CharacterBody2D

const DIST = 500
const TOSS_UP = -750
const DAMAGE = 1

var direction: int = 0

func _ready() -> void:
	var c = randi_range(0,12)
	if c == 0:
		%Character.text = "#"
	elif c == 1:
		%Character.text = "*"
	elif c == 2:
		%Character.text = "X"
	elif c == 3:
		%Character.text = "T"
	elif c == 4:
		%Character.text = "%"
	elif c == 5:
		%Character.text = "@"
	elif c == 6:
		%Character.text = ">"
	elif c == 7:
		%Character.text = "<"
	elif c == 8:
		%Character.text = "7"
	elif c == 9:
		%Character.text = "!"
	elif c == 10:
		%Character.text = "C"
	elif c == 11:
		%Character.text = "S"
	elif c == 12:
		%Character.text = "0"
	
	%AnimationPlayer.play("tossed")

func _physics_process(delta: float) -> void:
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif is_on_floor():
		await get_tree().create_timer(1).timeout
		queue_free()
		
	move_and_slide()
	
	if is_on_wall():
		direction *= -1 # Reverse direction

func toss_hammer(d: int) -> void:
	direction = d
	velocity.x = DIST * direction
	velocity.y = TOSS_UP
	move_and_slide()


func _on_damage_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtbox"):
		var dir: int
		if self.global_position.x - area.global_position.x > 0:
			dir = -1
		else:
			dir = 1
		area.get_parent().take_damage(DAMAGE, dir)
		queue_free()
