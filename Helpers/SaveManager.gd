extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var save : Dictionary
export (String, FILE) var template_path
# Called when the node enters the scene tree for the first time.
func _ready():
	var temp = $SaveLoader.load_json()
	if temp == null:
		create_save()
	else:	
		save = temp	
		
func create_save():
	save = $SaveLoader.load_json(template_path)
	$SaveLoader.save_json(save)
	
func available_levels():
	return save.get("AvailableLevels")
	
func update(available_levels):
	if save.get("AvailableLevels") == available_levels:
		return
	save["AvailableLevels"] = available_levels
	$SaveLoader.save_json(save)
	save = $SaveLoader.load_json()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
