extends KinematicBody2D

export var speed = 10
export var max_constraint = 800
export var min_constraint = 400

var direction = 1
var velocity = Vector2.ZERO
 
func _physics_process(_delta):
	if direction > 0 and not $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if direction < 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	velocity.x += direction*speed
	move_and_slide_with_snap(velocity, Vector2.UP)
	if direction > 0 and position.x >= max_constraint:
		velocity.x = 0
		direction *= -1
	if direction < 0 and position.x <= min_constraint:
		velocity.x = 0
		direction *= -1
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Platform" or collision.collider.name == "Wall":
			velocity.x = 0
			direction *= -1

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.die()
