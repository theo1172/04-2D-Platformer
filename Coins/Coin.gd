extends Area2D

export var score = 100
var coin_sound = null

func _ready():
	pass


func _on_Coin_body_entered(body):
	if body.name == "Player":
		Global.inc_score(score)
		queue_free()
		coin_sound = get_node_or_null("/root/Game/Sounds/Coin_Sound")
		if coin_sound != null:
			coin_sound.play()
