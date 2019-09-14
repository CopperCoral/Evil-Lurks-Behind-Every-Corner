extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var munition = "Infinite"
var up : bool = false
export (int) var damage

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func fire():
	if !$AnimationPlayer.is_playing():
		$ShlashSound.play()
		if up:
			swing_down()
		else:
			swing_up()
			
func swing_down():
	$AnimationPlayer.play("swing_down")
	up = false
			
func swing_up():
	$AnimationPlayer.play("swing_up")
	up = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DamageArea_body_shape_entered(body_id, body, body_shape, area_shape):
		if body != null:
			if body.has_method("take_damage"):
				body.take_damage(damage, body_shape)
