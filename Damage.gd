extends Area2D

var damaged = false
var damage = 0

func _ready():
	$Timer.start(0.2)


func _process(delta):
	if not damaged and get_overlapping_bodies() != []:
		for i in get_overlapping_bodies():
			if i in get_tree().get_nodes_in_group(GlobalVars.//)
				i.reduce_hp(damage)
		damaged = true


func _on_timer_timeout():
	pass # Replace with function body.
