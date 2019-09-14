extends Control

var max_health

func _ready():
	pass


func set_health(var health):
	$TextureProgress.value = float(health) / max_health * $TextureProgress.max_value