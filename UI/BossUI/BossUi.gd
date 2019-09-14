extends Control

func _ready():
	pass
	

func set_health(var health):
	$MarginContainer/BossHealthBar.set_health(health)

func set_max_health(var max_health):
	$MarginContainer/BossHealthBar.max_health = max_health
	
func boss_to_ui(boss):
	set_max_health(boss.life)
	set_health(boss.life)
	boss.connect("took_damage", self, "_on_boss_took_damage")
	
func _on_boss_took_damage(life : int):
	set_health(life)