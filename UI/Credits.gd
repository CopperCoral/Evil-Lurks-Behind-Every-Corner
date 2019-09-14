extends Control

signal credit_ended

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		emit_signal("credit_ended")