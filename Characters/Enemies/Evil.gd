extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var preys : Array = []
var current_target
var current_body_shape
var velocity = Vector2()
export (int) var speed
export (int) var damage
export (int) var life
signal died 
signal took_damage # How fast the enemy will move (pixels/sec).
# Called when the node enters the scene tree for the first time.
func _ready():
 pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func detect_characters(body):
	if body != null:
		add_prey(body)	
		
func add_prey(prey):
	preys.push_front(prey)
	
func direction() -> Vector2:
	var direction =  preys.front().position - self.position
	direction = direction.normalized()
	return direction
	
func _integrate_forces(state):
	if !preys.empty():
		if !$BreathingSound.playing:
			$BreathingSound.play()
		move(state)
		
func move(state):
		state.linear_velocity = direction() * state.get("step") * speed	

func collusion(body_id : int, body : PhysicsBody2D, body_shape : int, local_shape : int):
	if body != null:
		if body.get_collision_layer_bit(1) and body.has_method("take_damage"):
			current_target = body
			current_body_shape = body_shape
			melee_attack()
			$AttackTimer.start()

func melee_attack():
	if current_target != null and current_target.has_method("take_damage"):
		current_target.call("take_damage", damage, current_body_shape)
		
func take_damage(damage : int, body_shape : int):
	life -= damage
	emit_signal("took_damage", life)
	if life <= 0:
		die()
	return true
	
func die():
	$BreathingSound.stop()
	$DeathMarker.show()
	$EvilMarker.hide()
	$DeathSound.play()
	emit_signal("died")
	self.set_script(null)

func _on_Enemy_body_shape_exited(body_id, body, body_shape, local_shape):
	if body == current_target and body != null:
		$AttackTimer.stop()
		current_target = null
