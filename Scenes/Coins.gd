extends Label


func _process(delta):
	var player = get_parent().get_parent().get_player()
	text = str(player.coins)
