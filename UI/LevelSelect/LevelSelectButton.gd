extends TextureButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var level
var level_name
signal start_level
signal hovered_over

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelSelectButton_pressed():
	emit_signal("start_level", level) # Replace with function body.


func _on_LevelSelectButton_mouse_entered():
	if !disabled:
		emit_signal("hovered_over", level_name)

func set_sprite(sprite):
	$Level.texture = sprite
	
func enable():
	disabled = false
	$DisabledLevel.hide()