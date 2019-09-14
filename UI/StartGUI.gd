extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal game_started

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _start_game():
	$Music.stop()
	emit_signal("game_started")
