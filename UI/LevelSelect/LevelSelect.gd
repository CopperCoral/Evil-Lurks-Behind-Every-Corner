extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal selected_level
var buttons : Array
var levels : Array
var data : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons = $MarginContainer/VBoxContainer/HBoxContainer.get_children()


func set_data(data):
	self.data = data
	set_levels()
	set_level_names() 
	set_level_sprites()
	
func set_levels():
	var level = data.get("FirstLevel")
	for button in buttons:
		button.level = level
		level = data.get(level).get("NextLevel")	

func set_level_names():
	for button in buttons:
		var level_name = data.get(button.level).get("Name")
		button.level_name = level_name

func set_level_sprites():
	for button in buttons:
		var sprite_path = data.get(button.level).get("SpritePath")
		if sprite_path != "":
			set_level_sprite(button, sprite_path)

func set_level_sprite(button, sprite_path):
	var sprite = load(sprite_path)
	button.set_sprite(sprite)

func enable_levels(available_levels):
	for i in range(0, available_levels):
		buttons[i].enable()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var positions : Array = Array()
	for button in buttons:
		var top_middle = button.rect_global_position + Vector2(button.rect_size.x / 2, 0)
		positions.append(top_middle)
	$LevelConnectLine.set_points(positions)
	
func _on_LevelSelectButton_start_level(level):
	emit_signal("selected_level", level)


func _on_LevelSelectButton_hovered_over(level_name):
	if level_name != null:
		$MarginContainer/VBoxContainer/LevelName.text = level_name


func _on_LevelSelectButton_mouse_exited():
	$MarginContainer/VBoxContainer/LevelName.text = ""
