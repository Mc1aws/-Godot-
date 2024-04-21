extends TextureProgressBar

func _process(delta):
	self.value = get_parent().health
