extends "res://Objects/Weapon.gd"

var rng = RandomNumberGenerator.new()

func _ready():
	._ready()
	rng.randomize()

func fire():
	$BulletSpawnPosition.position.y += rng.randf_range(-15.0, 15.0)
	.fire()
	$BulletSpawnPosition.position.y = $FrontOfGun.position.y
