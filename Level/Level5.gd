extends "res://Level/Level.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var good_data : PackedScene
onready var keys = $Keys

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in keys.get_children():
		key.connect("picked_up", self, "_on_Key_picked_up") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Key_picked_up(key):
	keys.remove_child(key)
	if keys.get_child_count() == 0:
		spawn_good()
		
func spawn_good():
	var good = good_data.instance()#
	self.add_child(good)
	good.position = $GoodSpawn.position
	good.connect("got_good", self, "win_level")
	