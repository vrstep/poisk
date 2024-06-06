extends KinematicBody2D




func _ready():
	self.global_position = Global.player_initial_map_position 

# Player movement speed
export var speed = 85
onready var myplayer = $player_animation
onready var player = $player
onready var hitsound = $hit
onready var hurt = $"../enemy/weapon"
onready var hurt2 = $"../minotaur/weapon"
onready var UI = $"/root/Hud/hearts"
var prev = "null"
var attack = false
var money = 0



# Player stats
var health = 5
var health_max = 5
var health_regeneration = 1
var mana = 100
var mana_max = 100
var mana_regeneration = 2


func _physics_process(delta):
	# Get player input
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	
	
	if Input.is_action_pressed("ui_right") && attack == false:
		myplayer.play("player_right")
		prev = "right"
	elif Input.is_action_pressed("ui_left") && attack == false:
		myplayer.play("player_left")
		prev = "left"
	elif Input.is_action_pressed("ui_up") && attack == false:
		myplayer.play("player_up")
		prev = "up"
	elif Input.is_action_pressed("ui_down")&& attack == false:
		myplayer.play("player_down")
		prev = "down"
	else:
		if attack == false:
			if prev == "up":
				myplayer.play("idle_up")
			elif prev == "down":
				myplayer.play("idle_down")
			elif prev == "left":
				myplayer.play("idle_left")
			elif prev == "right":
				myplayer.play("idle_right")
	if Input.is_action_just_pressed("ui_shift"):
		hitsound.play()
		attack = true
		if prev == "up":
			myplayer.play("player_hit_up")
			$hitboxes/up.disabled = false
		elif prev == "down":
			myplayer.play("player_hit_down")
			$hitboxes/down.disabled = false
		elif prev == "left":
			myplayer.play("player_hit_left")
			$hitboxes/left.disabled = false
		elif prev == "right":
			myplayer.play("player_hit_right")
			$hitboxes/right.disabled = false
			
	if health <= 0:
		self.global_position = Global.player_initial_map_position
		health = 5
		UI.rect_size.x = health * 17
		
	
		
		
	var movement = speed * direction * delta
	move_and_collide(movement)






func _on_player_animation_animation_finished():
	if myplayer.animation == "player_hit_down" or myplayer.animation == "player_hit_up" or myplayer.animation == "player_hit_right" or myplayer.animation == "player_hit_left":
		$hitboxes/down.disabled = true
		$hitboxes/left.disabled = true
		$hitboxes/right.disabled = true
		$hitboxes/up.disabled = true
		
		attack = false



func _on_Area2D_body_entered(body):
	money += 1


func _on_hurtbox_area_entered(area):
	if area == hurt or area == hurt2:
		health -= 1
		UI.rect_size.x = health * 17
		
		print(health)

