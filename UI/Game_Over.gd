extends Control

var button_sound = null

func _ready():
	$Label.text = "Your score: " + str(Global.score) + "\nThanks for playing!"


func play_sound():
	button_sound = get_node_or_null("/root/Game/Button_Sound")
	if button_sound != null:
		button_sound.play()
		
func _on_Play_Again_pressed():
	play_sound()
	Global.score = 0
	Global.lives = 5
	Global.level = 1
	yield(button_sound, "finished")
	get_tree().change_scene("res://Levels/Level_1/Level_1.tscn")


func _on_Exit_pressed():
	play_sound()
	yield(button_sound, "finished")
	get_tree().quit()
