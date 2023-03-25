extends Node

var score = 0
var lives = 5
var level = 1
var coins = null
var total_coins = null

func inc_score(s):
	score += s

func update_lives():
	lives -= 1
	if lives <= 0:
		get_tree().change_scene("res://UI/Game_Over.tscn")
		
#func dec_score():
#	if level == 1:
#		coins = get_node_or_null("/root/Game/Coin_Container")
#		total_coins = 5
#	if level == 2:
#		coins = get_node_or_null("/root/Game/Coin_Container")
#		total_coins = 5
#	if level == 3:
#		coins = get_node_or_null("/root/Game/Coin_Container")
#		total_coins = 8
#	score -= (total_coins - coins.get_child_count())*100
#	if score < 0:
#		score = 0
			

# SAVE AND LOAD ------------------------------------------------

const SAVE_PATH = "user://savegame.sav"
const SECRET = "C220 Is the Best!"
var save_file = ConfigFile.new()

onready var HUD = get_node_or_null("/root/Game/CanvasLayer/HUD")
onready var Coins = get_node_or_null("/root/Game/Coin_Container")
onready var Game = load("res://Levels/Level_1/Level_1.tscn")
onready var Coin = load("res://Coins/Coin.tscn")

var save_data = {
	"general": {
		"score":0
		,"coins":[] 	
	}
}


func _ready():
	update_score(0)

func update_score(s):
	save_data["general"]["score"] += s
	HUD.find_node("Score").text = "Score: " + str(save_data["general"]["score"])


func restart_level():
	HUD = get_node_or_null("/root/Game/CanvasLayer/HUD")
	Coins = get_node_or_null("/root/Game/Coin_Container")
	
	for c in Coins.get_children():
		c.queue_free()
	for c in save_data["general"]["coins"]:
		var coin = Coin.instance()
		coin.position = str2var(c)
		Coins.add_child(coin)
	update_score(0)
	get_tree().paused = false

# ----------------------------------------------------------

func save_game():
	save_data["general"]["coins"] = []					# creating a list of all the coins and mines that appear in the scene
	if Coins != null:
		for c in Coins.get_children():
			save_data["general"]["coins"].append(var2str(c.position))	# get a json representation of each of the coins

	var save_game = File.new()						# create a new file object
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)	# prep it for writing to, make sure the contents are encrypted
	save_game.store_string(to_json(save_data))				# convert the data to a json representation and write it to the file
	save_game.close()							# close the file so other processes can read from or write to it
	
func load_game():
	var save_game = File.new()						# Create a new file object
	if not save_game.file_exists(SAVE_PATH):				# If it doesn't exist, skip the rest of the function
		return
	save_game.open_encrypted_with_pass(SAVE_PATH, File.READ, SECRET)	# The file should be encrypted
	var contents = save_game.get_as_text()					# Get the contents of the file
	var result_json = JSON.parse(contents)					# And parse the JSON
	if result_json.error == OK:						# Check to make sure the JSON got successfully parsed
		save_data = result_json.result				# If so, load the data from the file into the save_data lists
	else:
		print("Error: ", result_json.error)
	save_game.close()							# Close the file so other processes can read from or write to it
	
	var _scene = get_tree().change_scene_to(Game)				# Load the scene
	call_deferred("restart_level")						# When it's done being loaded, call the restart_level method
