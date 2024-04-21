extends RigidBody2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.coins += 1
		get_parent().remove_child(self)
		queue_free()
