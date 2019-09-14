extends "res://Characters/Enemies/Evil.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var turn_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	var weapon_shape = $Gun/CollusionShape.duplicate()
	weapon_shape.name = "WeaponShape"
	self.add_child(weapon_shape)
	$WeaponShape.global_position = $Gun/CollusionShape.global_position
	$Gun/CollusionShape.disabled = true # Replace with function body.

func direction() -> Vector2:
	var gap_length = 150
	var direction =  preys.front().position - self.position
	direction = direction.normalized()  
	var gap_position = preys.front().position - (gap_length * direction)
	var gap_direction : Vector2 = gap_position - self.position
	if gap_direction.length() < 10:   #small offset to avoid bouncing
		return Vector2(0,0)
	gap_direction = gap_direction.normalized()
	return gap_direction

func _integrate_forces(state):
	if !preys.empty():
		state.linear_velocity = direction() * state.get("step") * speed
		rotate_to_enemy(state)
		shooting()

func rotate_to_enemy(state):
	state.angular_velocity = self.get_angle_to(preys.front().position) * turn_speed

func shooting():
	$RayCast2D.force_raycast_update()
	var in_sight = $RayCast2D.get_collider()
	if(in_sight == preys.front()):
		$Gun.fire()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
