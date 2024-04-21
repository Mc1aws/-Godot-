extends Node2D

func get_player():
	return $Player

func get_damage():
	pass



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.health = 0


func _on_finish_body_entered(body):
	if body.name == "Player":
		if body.p_key == 1 and body.b_key == 1:
			body.position.x = 3356
			body.position.y = 388
