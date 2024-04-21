extends Node2D

@onready var pause_menu = $"../CanvasLayer/PauseMenu"

var game_paused = false

func _process(delta):
	if Input.is_action_just_pressed('Pause'):
		game_paused = !game_paused
		if game_paused == false:
			get_tree().paused = true
			pause_menu.show()
		else:
			get_tree().paused = false
			pause_menu.hide()



func _on_продолжить_pressed():
	get_tree().paused = false
	pause_menu.hide()

func _on_выйти_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Меню.tscn")

