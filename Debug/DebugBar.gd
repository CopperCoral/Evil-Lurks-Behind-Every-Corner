extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Array, String) var debug_names
enum MODE {automatic, manual}
export (MODE) var mode


func _process(delta):
	self.set_rotation(self.get_rotation() - self.get_global_transform().get_rotation())
	if mode == MODE.automatic:
		update_values()
# Called when the node enters the scene tree for the first time.
func _ready():
	for debug_name in debug_names:
		var name_label = Label.new()
		name_label.name = debug_name
		name_label.size_flags_horizontal = 3
		name_label.size_flags_vertical = 3
		var variable_label = name_label.duplicate()
		name_label.text = debug_name
		$HBoxContainer/Names.add_child(name_label)
		$HBoxContainer/Variables.add_child(variable_label)
		
func update_value(name : String, value):
	$HBoxContainer/Variables.get_node(name).text = String(value)
	
func update_values():
	for debug_name in debug_names:
		update_value(debug_name, get_parent().get(debug_name))
# Called every frame. 'delta' is the elapsed time since the previous frame.

