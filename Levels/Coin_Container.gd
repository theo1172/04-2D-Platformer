extends Node2D


func _physics_process(_delta):
	if not has_node("Player"):
		var player = Player.instance()
		player.position = starting_position
		add_child(player)
		player.collision_layer = 2
		player.collision_mask = 2
