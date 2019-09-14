extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
var on_going : bool = true
signal game_over
signal won_level

func _ready():
#	$CanvasModulate.show()
	var shooting_enemies = get_tree().get_nodes_in_group("shooting_enemies")
	for ranged_weapon in get_tree().get_nodes_in_group("ranged_weapon"):
		ranged_weapon.connect("fired", self, "spawn_bullet")


func spawn(thing_resource : PackedScene, position):
	var thing = thing_resource.instance()
	thing.position = position
	call_deferred("add_child", thing) # Replace with function body.

func spawn_bullet(bullet_data : PackedScene, position, rotation, munition):
		var bullet : RigidBody2D = bullet_data.instance()
		add_child(bullet)
		bullet.position = position
		bullet.rotation_degrees = rotation
		bullet.fire()
		
func player_death():
	if on_going:
		emit_signal("game_over")
		on_going = false

func _on_weapon_acquired(new_weapon : Node, old_weapon : Node):
	remove_child(old_weapon)
	new_weapon.connect("fired", self, "spawn_bullet")


func _on_Player_weapon_thrown(weapon : RigidBody2D, position, rotation):
	self.add_child(weapon)
	weapon.global_position = position
	weapon.global_rotation = rotation
	weapon.get_node("CollusionShape").disabled = false
	weapon.mode = weapon.MODE_RIGID
	
func win_level():
	if on_going:
		$VictorySound.play()
		$Player.set_script(null)
		emit_signal("won_level")
		on_going = false

func get_player():
	return $Player
