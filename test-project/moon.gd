extends Sprite2D
var speed = 10
var angular_speed = 0.01

func _process(delta):
	rotation += angular_speed * delta
	var velocity = Vector2.RIGHT.rotated(rotation) * speed
	position += velocity * delta
