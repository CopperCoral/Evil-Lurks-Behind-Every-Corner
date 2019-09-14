extends "res://Objects/guns/bullets/Bullet.gd"

func collusion(body_id : int, body : Node, body_shape : int, local_shape : int):
	if body != null:
		if !body.is_in_group("boss"):
			.collusion(body_id, body, body_shape, local_shape)