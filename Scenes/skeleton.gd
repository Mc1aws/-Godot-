extends CharacterBody2D

const SPEED = 50.0

var health = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var target = false
var atk = false
var alive = true

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	if alive == true:
		if health > 0:
			if not is_on_floor():
				velocity.y += gravity * delta
			var player = get_parent().get_player()
			var direction = (player.position - self.position).normalized()
			if target == true:
				velocity.x = direction.x * SPEED
			else:
				velocity.x = 0
			if atk == true:
				velocity.x = 0
			else:
				update_animation()
			move_and_slide()
		else: death()

func _on_visible_area_body_entered(body):
	if body.name == "Player":
		target = true

func _on_visible_area_body_exited(body):
	if body.name == "Player":
		target = false

func update_animation():
	if velocity.x:
		anim.play("go")
		if velocity.x > 0:
			$DamageArea/dmg.position.x = 7.5
			$AgrArea/Agr.position.x = 12.5
			anim.flip_h = false
		else: 
			$DamageArea/dmg.position.x = -13
			$AgrArea/Agr.position.x = -18
			anim.flip_h = true
	else:
		anim.play('idle')

func _on_damage_area_body_entered(body):
	if body.name == "Player":
		if atk == false:
			atk = true
			$Timer.start(0.33)
			anim.play("attack")
			await $Timer.timeout
			$Audio/Attack.playing = true
			$Timer.start(0.33)
			await $Timer.timeout
			$AgrArea/Agr.disabled = false
			$DamageArea/dmg.disabled = true
			$Timer.start(0.05)
			await $Timer.timeout
			$DamageArea/dmg.disabled = false
			$AgrArea/Agr.disabled = true
			atk = false

func death():
	alive = false
	anim.play("die")
	$Timer.start(1)
	await $Timer.timeout
	queue_free()
	
func _on_agr_area_body_entered(body):
	if body.name == "Player":
		body.health -= 50
		$Audio/Hit.playing = true
