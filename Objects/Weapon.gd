extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var bullet_data
export (bool) var next_bullet_loaded
var thrown : bool = false
export (int) var munition : int
export (float) var load_time : float
signal fired
# Called when the node enters the scene tree for the first time.
func _ready():
	$NextBulletTimer.wait_time = load_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fire():
	if next_bullet_loaded and munition > 0 and no_walls():
		munition -= 1
		emit_signal("fired", bullet_data, $BulletSpawnPosition.global_position, self.global_rotation_degrees, munition)
		next_bullet_loaded = false
		$NextBulletTimer.start()
		$GunshotLight/GunShotLightAnimation.play("gunshot")
		$GunShotSound.play()


func load_next_bullet():
	next_bullet_loaded = true # Replace with function body.

func no_walls():
	if $WallChecker != null:
		return $WallChecker.get_collider() == null
	return true