extends Node2D

onready var Player = load("res://Player/Player.tscn")
var starting_position = Vector2(200,200)
var die_sound = null

func _physics_process(_delta):
	if not has_node("Player"):
		var player = Player.instance()
		player.position = starting_position
		add_child(player)
		player.collision_layer = 2
		player.collision_mask = 2
