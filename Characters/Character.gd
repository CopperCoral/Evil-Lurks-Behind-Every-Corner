extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed  # How fast the player will move (pixels/sec).
var delta = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	self.delta += delta

func _integrate_forces(state):
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
	state.linear_velocity = velocity * delta
	delta = 0