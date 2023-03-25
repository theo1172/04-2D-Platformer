extends Control

var button_sound = null

func _ready():
	pass

func play_sound():
	button_sound = get_node_or_null("/root/Game/Sounds/Button_Sound")
	if button_sound != null:
		button_sound.play()

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		play_sound()
		if visible:
			hide()
			get_tree().paused = false
		else:
			show()
			get_tree().paused = true

func _on_Continue_pressed():
	play_sound()
	if visible:
		hide()
		get_tree().paused = false

func _on_Save_pressed():
	play_sound()
	Global.save_game()

func _on_Load_pressed():
	play_sound()
	yield(button_sound, "finished")
	Global.load_game()

func _on_Quit_pressed():
	play_sound()
	yield(button_sound, "finished")
	get_tree().quit()
