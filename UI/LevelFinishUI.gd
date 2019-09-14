extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal next_level
signal level_select

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NextLevelButton_pressed():
	emit_signal("next_level") # Replace with function body.


func _on_LevelSelectButton_pressed():
	emit_signal("level_select")

func play_sound():
	$VictorySound.play()