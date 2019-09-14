extends "res://Level/Level.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var lights_off
# Called when the node enters the scene tree for the first time.
func _ready():
	if lights_off:
		$CanvasModulate.queue_free()
		$Lamps.queue_free()