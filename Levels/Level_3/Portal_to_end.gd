extends Area2D

var door_sound = null

func _on_Portal_body_entered(body):
	if body.name == "Player":
		door_sound = get_node_or_null("/root/Game/Sounds/Door_Sound")
		if door_sound != null:
			door_sound.play()
		$AnimatedSprite.play("open")
		yield($AnimatedSprite, "animation_finished")
		get_tree().change_scene("res://UI/Game_Over.tscn")
