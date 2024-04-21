extends RigidBody2D


func _input(event):
	if event.is_action_pressed("take"):
		var player = get_parent().get_player()
		if abs(player.position.x - self.position.x) < 16 and abs(player.position.y - self.position.y) < 16:
			get_parent().remove_child(self)
			queue_free()
			player.p_key = 1
		
