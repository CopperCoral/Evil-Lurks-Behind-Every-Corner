extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var levels_data : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	levels_data = $LevelLoader.load_json()
	var available_levels = int($SaveManager.available_levels())
	$LevelManager.set_data(levels_data, available_levels)

	
func get_level_data():
	var level_data = $LevelManager.current_level_data()
	return level_data
	
func set_level(level_name):
	$LevelManager.current_level = level_name	
	
func set_next_level(level_name):
	$LevelManager.go_next()

func remove_level():
	remove_child($Level)
	
func get_level():
	return $Level

func get_level_name():
	return $LevelManager.current_level
	
func get_available_levels():
	return $LevelManager.available_levels
	
func win_level():
	$LevelManager.win_level()
	$SaveManager.update($LevelManager.available_levels)
	
func is_final_level():
	return levels_data.get("FinalLevel") == $LevelManager.current_level
