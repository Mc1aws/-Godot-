extends Node2D



func _on_играть_pressed():
	get_tree().change_scene_to_file("res://Scenes/Игра.tscn")


func _on_выйти_pressed():
	get_tree().quit()
