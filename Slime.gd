extends CharacterBody2D

var alive = true
var health = 100
var SPEED = 0.3
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimatedSprite2D
@onready var path = get_parent()
@onready var player = get_parent().get_parent().get_parent().get_player()
var direction = 0

func _physics_process(delta):
	if alive == true:
		if health > 0:
			if not is_on_floor():
				velocity.y += gravity * delta
			anim.play("go")
			if direction == 0:
				anim.flip_h = true
				path.progress_ratio += SPEED * delta
				if path.progress_ratio >= 1:
					direction = 1
					path.progress_ratio = 1
					$Audio/Slime1.playing = true
			if direction == 1:
				anim.flip_h = false
				path.progress_ratio -= SPEED * delta
				if path.progress_ratio <= 0:
					direction = 0
					path.progress_ratio = 0
					$Audio/Slime2.playing = true
			move_and_slide()
		else: death()

func _on_damage_area_body_entered(body):
	if body.name == "Player":
		body.health -= 50
		$Audio/Hit.playing = true

func death():
	alive = false
	anim.play("die")
	$Timer.start(1)
	await $Timer.timeout
	queue_free()
