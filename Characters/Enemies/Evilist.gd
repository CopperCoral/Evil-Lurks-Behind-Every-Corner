extends "res://Characters/Enemies/Eviler.gd"

func shooting():
	for child in get_children():
		if child.is_in_group("ranged_weapon"):
			child.fire()
			

