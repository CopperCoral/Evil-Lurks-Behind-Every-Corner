extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed
export (int) var damage 

# Called when the node enters the scene tree for the first time.
#func _ready():

func fire():
	var impulse_direction = $AimPosition.global_position - global_position 
	impulse_direction = impulse_direction.normalized() * speed
	self.apply_impulse(Vector2(0,0), impulse_direction)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func collusion(body_id : int, body : Node, body_shape : int, local_shape : int):
	if body != null:
		if body.has_method("take_damage"):
			if body.take_damage(damage, body_shape):
				self.decrease_durability()
# Replace with function body.
		
func decrease_durability():
	if damage > 0:
		self.damage -= 1

func _on_Despawner_timeout():
	get_parent().remove_child(self) # Replace with function body.
