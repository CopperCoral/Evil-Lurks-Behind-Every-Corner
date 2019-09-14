extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var game_data : PackedScene



# Called when the node enters the scene tree for the first time.
func _ready():
	pass# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_game_started():
	remove_child($StartScreen)
	var game = game_data.instance()
	add_child(game)

	
