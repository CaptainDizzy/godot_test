extends AnimatableBody2D

@export var speed: float = 0.25

@onready var path_follow: PathFollow2D = $"../Path2D/PathFollow2D"

var direction: float = 1.0

func _physics_process(delta: float) -> void:
	var target = path_follow.global_position
	var delta_pos = target - global_position
	
	path_follow.progress_ratio += speed * delta * direction
	
	if path_follow.progress_ratio >= 1.0:
		path_follow.progress_ratio = 1.0
		direction = -1.0
	elif path_follow.progress_ratio <= 0.0:
		path_follow.progress_ratio = 0.0
		direction = 1.0
	
	move_and_collide(delta_pos)
