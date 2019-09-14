extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed : int
export (int) var life : int
export (int) var throw_strength
export (float) var turn_speed
export (PackedScene) var starting_weapon : PackedScene# How fast the player will move (pixels/sec).
var grabable_object : Node = null
var invinceble : bool = false
signal existed
signal died
signal weapon_acquired
signal weapon_thrown
signal took_damage

# Called when the node enters the scene tree for the first time.
func _ready():
	if starting_weapon != null:
		var weapon : Node = starting_weapon.instance()
		call_deferred("acquire_weapon", weapon)

func _process(delta):
	if Input.is_action_pressed("ui_mouseclick") and $Weapon != null:
		$Weapon.fire()
	if Input.is_action_pressed("ui_throw") and $Weapon != null:
		throw()
	if Input.is_action_pressed("ui_pickup"):
		acquire_weapon(grabable_object)
	if $WeaponShape and $Weapon.is_in_group("axe"):
		$WeaponShape.global_position = $Weapon/CollusionShape.global_position #Due to Weapon offset
		$WeaponShape.scale = $Weapon.scale		
		$WeaponShape.rotation = $Weapon.rotation
		pass
func acquire_weapon(weapon : Node):
	if weapon != null and $Weapon == null:
		if weapon.is_in_group("weapon"):	
			var new_weapon : Node = weapon.duplicate()
			new_weapon.name = "Weapon"
			new_weapon.mode = weapon.MODE_STATIC
			self.add_child(new_weapon)
			emit_signal("weapon_acquired", $Weapon, weapon)
			$Weapon.position = $WeaponPosition.position
			$Weapon.rotation_degrees = 0 # rotation is relative to parent -> zero is rotation of parent
			var weapon_shape = $Weapon/CollusionShape.duplicate()
			weapon_shape.name = "WeaponShape"
			self.add_child(weapon_shape)
			$WeaponShape.global_position = $Weapon/CollusionShape.global_position
			$Weapon/CollusionShape.disabled = true
	
func disarm():
	var weapon = $Weapon
	if weapon != null:
		self.remove_child($WeaponShape)
		var weapon_position = weapon.global_position
		var weapon_rotation = weapon.global_rotation
		self.remove_child(weapon)
		grabable_object = null
		emit_signal("weapon_thrown", weapon, weapon_position, weapon_rotation)
	return weapon
		
func throw():
	var weapon = disarm()
	var impulse_direction = weapon.global_position - self.global_position
	impulse_direction = impulse_direction.normalized() * self.throw_strength
	weapon.apply_central_impulse(impulse_direction)
	weapon.apply_torque_impulse(1000)
	
func _integrate_forces(state : Physics2DDirectBodyState):
	movement(state)
	aiming(state)

func movement(state : Physics2DDirectBodyState):
	state.linear_velocity = velocity() * state.get("step")
	
func velocity() -> Vector2:
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	return velocity

func aiming(state : Physics2DDirectBodyState):
	var mouse_position : Vector2 = get_global_mouse_position()
	state.angular_velocity = get_angle_to(mouse_position) * turn_speed
	
func take_damage(damage : int, body_shape : int):
	if body_shape == 0 and !invinceble: #The ID of the "Body" child shape is 0
		invinceble = true
		$Invincibility.start()
		life -= damage
		$HitSound.play()
		emit_signal("took_damage", life)
		if life <= 0:
			die()
		return true
	return false
	
func die():
	$DeathMarker.show()
	emit_signal("died")
	self.set_script(null)


func _on_Grabber_body_entered(body):
	if grabable_object == null && body != null:
		grabable_object = body


func _on_Grabber_body_exited(body):
	if grabable_object != null && body == grabable_object:
		grabable_object = null # Replace with function body.


func _on_Invincibility_timeout():
	invinceble = false # Replace with function body.
