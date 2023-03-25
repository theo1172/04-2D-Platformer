extends KinematicBody2D

var player = null
onready var ray = $RayCast2D
export var speed = 150
export var looking_speed = 100
export var damage = 10

func _physics_process(_delta):
	player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		if c: 
			var velocity = ray.cast_to.normalized()*looking_speed
			if c.name == "Player":
				velocity = ray.cast_to.normalized()*speed
			move_and_slide(velocity, Vector2(0,0))
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				if collision.collider.name == "Player":
					collision.collider.die()
					position = Vector2(760, 245)
			if velocity.x > 0 and not $AnimatedSprite.flip_h:
				$AnimatedSprite.flip_h = true
			if velocity.x < 0 and $AnimatedSprite.flip_h:
				$AnimatedSprite.flip_h = false
					
