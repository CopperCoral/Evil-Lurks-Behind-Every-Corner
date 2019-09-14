extends Node

var data : Dictionary
export (int) var available_levels : int
var current_level
var highest_uncompleteted_level


func _ready():
	pass

func set_data(data, available_levels):
	self.data = data
	self.available_levels = available_levels
	highest_uncompleteted_level = data.get("FirstLevel")	
	for i in range(1, available_levels):
		highest_uncompleteted_level = next_level(highest_uncompleteted_level)
	
func win_level():
	if current_level == highest_uncompleteted_level and highest_uncompleteted_level != data.get("FinalLevel"):
		highest_uncompleteted_level = next_level(highest_uncompleteted_level)
		available_levels += 1
	
func go_next():
	current_level = next_level(current_level)	
	
func next_level(level):
	return data.get(level).get("NextLevel")

func current_level_data():
	var level_path = data.get(current_level).get("DataPath")
	var level_data = load(level_path)
	return level_data
	
func next_level_data(level):
	data.get(level).get("NextLevel")

func get_level_data(level):
	var level_data = load(data.get(level).get("DataPath"))
	return level_data
