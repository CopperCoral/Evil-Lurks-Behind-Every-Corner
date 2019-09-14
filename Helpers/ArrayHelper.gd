extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func minus(minuend : Array, subtrahend : Array) -> Array:
	var difference : Array = []
	for object in minuend:
		if !subtrahend.has(object):
			difference.append(object)
	return difference

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
