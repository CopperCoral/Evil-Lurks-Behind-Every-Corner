extends "res://Level/Level.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "HTML5":
		lights_off()
		
func lights_off():
	$CanvasModulate.queue_free()
	$Lamps.queue_free()