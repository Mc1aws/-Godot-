extends TextureProgressBar

func _process(delta):
	var player = get_parent().get_parent().get_player()
	self.value = player.health


