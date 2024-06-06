extends KinematicBody2D

var speed = 65
var motion = Vector2.ZERO
var player = null
var dir = Vector2(0, 0)
onready var anim = $enemy_animation
onready var plr = $"../Player"
onready var hurt = $"../Player/hitboxes"
onready var plr2 = $"../enemy"
var area = 0
var hp = 15



func _physics_process(delta):
	
	motion = Vector2.ZERO
	if hp <= 0:
		queue_free()
	if plr.health == 0:
		area = 0
	if area == 1:
		dir = position.direction_to(player.position)
		
		motion = dir * speed
		if dir > Vector2(0,0):
			anim.flip_h = false
			anim.play("run_right")
		elif dir < Vector2(0,0):
			anim.flip_h = true
			anim.play("run_right")
		
	elif area == 2 and plr.health != 0:
		dir = position.direction_to(player.position)
		motion = dir * speed
		if dir > Vector2(0,0) and dir < Vector2(1,0):
			anim.flip_h = false
			anim.play("attack_right")
			$weapon/kopye.disabled = false
		elif dir < Vector2(0,0) and dir > Vector2(-1,0):
			anim.flip_h = true
			anim.play("attack_right")
			$weapon/kopye2.disabled = false
	



	motion = move_and_slide(motion)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(plr):
	player = plr
	area = 1
	


func _on_Area2D_body_exited(plr):
	player = null
	area = 0
	anim.play("idle")

func _on_is_close_body_entered(body):
	
	area = 2 # Replace with function body.


func _on_is_close_body_exited(body):
	area = 1


func _on_hit_area_entered(body):
	if body == hurt:
		hp -= 1
		print(hp)


func _on_enemy_animation_animation_finished():
	if anim.animation == "attack_right":
		$weapon/kopye.disabled = true
		$weapon/kopye2.disabled = true




