extends "res://Level/Level.gd"

onready var boss = $Evilist 
export (PackedScene) var good_data : PackedScene


func _on_boss_died():
	var good = good_data.instance()#
	self.add_child(good)
	good.position = $GoodSpawn.position
	good.connect("got_good", self, "win_level")
	
func get_boss():
	return boss