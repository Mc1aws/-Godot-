extends Camera2D

func _process(delta):
	self.position.x += 100 * delta
	$AnimatedSprite2D.play("default")
