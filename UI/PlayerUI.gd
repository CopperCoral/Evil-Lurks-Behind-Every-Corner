extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func player_to_ui(player : Node):
	set_health(player.life)
	player.connect("took_damage", self, "_on_Player_took_damage")
	set_health(player.life)
	player.connect("weapon_acquired", self, "_on_Player_acquired_weapon")


func set_health(health):
	$MarginContainer/HBoxContainer/CenterContainer2/Health.text = str(health)
	
func set_ammunition(ammunition):
	$MarginContainer/HBoxContainer/CenterContainer/Ammunition.text = str(ammunition)
	
func _on_Player_took_damage(health):
	set_health(health)
	
func _on_Player_acquired_weapon(new_weapon, old_weapon):
	set_ammunition(new_weapon.munition)
	new_weapon.connect("fired", self, "_on_Weapon_fired")
	
func _on_Weapon_fired(bullet_data : PackedScene, position, rotation, munition):
	set_ammunition(munition)
	