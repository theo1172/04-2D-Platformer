extends KinematicBody2D

export var speed = 8

var direction = 1
var velocity = Vector2.ZERO
 
func _physics_process(_delta):
	if direction > 0 and not $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if direction < 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	velocity.x += direction*speed
	move_and_slide_with_snap(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Ground":
			velocity.x = 0
			direction *= -1

func _ready():
	pass
	

