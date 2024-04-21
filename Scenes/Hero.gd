extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0


@onready var anim = $Sprite
@onready var menu = $"../CanvasLayer/Dead_menu"

var currect_health = 100
var health = 100
var coins = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var p_key = 0
var b_key = 0
var alive = true
var atk = false

func _physics_process(delta):
		if (alive == true) and (atk == false):
			if health > 0:
				if not is_on_floor():
					velocity.y += gravity * delta

				
				if Input.is_action_just_pressed("jump") and is_on_floor():
					velocity.y = JUMP_VELOCITY
					$Audio/Jump.playing = true

				var direction = Input.get_axis("go_left", "go_right")
				if direction:
					velocity.x = direction * SPEED
				else:
					velocity.x = move_toward(velocity.x, 0, SPEED)
					
				updateanimation()
				move_and_slide()
			else: death()

func _input(event):
	if event.is_action_pressed("attack"):
		if atk == false:
			$Audio/Attack.playing = true
			atk = true
			$Timer.start(0.33)
			anim.play("attack")
			await $Timer.timeout
			$Area2D/DamageArea.disabled = false
			$Timer.start(0.05)
			await $Timer.timeout
			$Area2D/DamageArea.disabled = true
			atk = false
			
		

func updateanimation():
	if velocity.x:
		anim.play("run")
	else:
		anim.play("idle")
	if Input.is_action_just_pressed("go_left"):
		anim.flip_h = true
		$Area2D/DamageArea.position.x = -33
	elif Input.is_action_just_pressed("go_right"):
		anim.flip_h = false
		$Area2D/DamageArea.position.x = 33
	if Input.is_action_just_pressed("jump"):
		anim.play("jump")
	elif velocity.y > 0:
		anim.play('falling')
		
func _on_area_2d_body_entered(body):
	if body.name == "Skelet" or  body.name == "Skelet2" or body.name == "Slime":
		body.health -= 50
		if body.name == "Skelet" or  body.name == "Skelet2":
			$Audio/Hit_bones.playing = true
		elif body.name == "Slime": $Audio/Hit_slime.playing = true

func death():
	alive = false
	anim.play("dead")
	$Dead.start(0.76)

func _on_dead_timeout():
	get_tree().paused = true
	menu.show()


func _on_restart_pressed():
	get_tree().paused = false
	queue_free()
	menu.hide()
	get_tree().reload_current_scene()



func _on_quit_pressed():
	get_tree().paused = false
	menu.hide()
	get_tree().change_scene_to_file("res://Scenes/Меню.tscn")
