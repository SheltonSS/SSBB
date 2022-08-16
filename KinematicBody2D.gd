extends KinematicBody2D

onready var player := get_tree().get_root().get_node("MainScene").get_node("Player")
onready var camera := get_tree().get_root().get_node("MainScene").get_node("Camera2D")
var velocity = Vector2(1,0)
var target = Vector2(0,0)
var targetarea = 20

var direction : Vector2
var last_direction = Vector2(0, 1)
var bounce_countdown = 0


var actspeed = 240
var flingspeed = actspeed*3
var idlespeed = 50
var speedlist = [idlespeed,flingspeed,actspeed]
var curspeed = 0 

var onscreen = true 
var bouncetimer = 175

var flingtimer = 160
var hittimer = 50

var IDLE = "idle"
var FLING = "fling"
var SHOOT = "shoot"
var ASLEEP = "asleep"
var ACTIVE = "active"
var statelist = [IDLE, FLING, SHOOT, ASLEEP,ACTIVE]
var state = ""

# Random number generator
var rng = RandomNumberGenerator.new()

#====================================================================================================
func _ready():
	var startpoint = position
	state = IDLE
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#if the slime is around the players position it is affected by the boundry walls 
	if (position.distance_to(player.position)) <= targetarea*4:
		set_collision_mask(513)
	if state == FLING:
		fling(delta)
	elif state == IDLE:
		idle(delta)
	if Input.is_action_just_pressed("fling"):
		print("flung")
		flingtimer = 250
		state = FLING
#====================================================================================================
#---------------------------------------------------------------------------------------------
func fling(delta ):
	#fling yourself towards the current player position and bounce of the walls at random 
	flingtimer -= 1
	if flingtimer == 0:
		target = player.position
		velocity = target - position
	elif flingtimer < 0 && flingtimer > -250*2:
		curspeed = flingspeed
		var collision_info = move_and_collide(velocity.normalized()*delta*flingspeed)
		if position.distance_to(target) <= targetarea:
			print("target")
			set_collision_mask(513)
		
		if collision_info:
			if collision_info.get_collider() == player:
				velocity = velocity.bounce(collision_info.normal)
				
			elif collision_info.collider.name == "Kbodyboundry":
				print( collision_info.get_collider())
				if onscreen == true:
					print("on screen bounce")
					velocity = velocity.bounce(collision_info.normal)
	elif flingtimer < -250:
		state=IDLE
		
#---------------------------------------------------------------------------------------------
func idle(delta):
	flingtimer = 125
#	curspeed = idlespeed
	set_collision_mask(1)
	var movement = direction * curspeed * delta
	var collision = move_and_collide(movement)
	
	if collision != null and collision.collider.name != "Player":
		print("colliding with not player")
		direction = direction.rotated(rng.randf_range(PI/4, PI/2))
		bounce_countdown = rng.randi_range(2, 5)
	
#---------------------------------------------------------------------------------------------
func shoot():
	pass
	
#---------------------------------------------------------------------------------------------
func asleep():
	pass
	
func Active(delta):
	pass
#	increase speed, keep your distance  from both the player and other eniemes 
#---------------------------------------------------------------------------------------------
#====================================================================================================
func _on_Area2D_area_exited(area):
	if area.name == "Camarea":
		set_collision_mask(1)
		print("exit")

func _on_Timer_timeout():
	if state == IDLE:
		# Calculate the position of the player relative to the skeleton
		var player_relative_position = player.position - position
		if player_relative_position.length() <= 16:
			curspeed = actspeed
			print("aproaching target")
			# If player is near, don't move but turn toward it
			state = ACTIVE
			direction = Vector2.ZERO
			last_direction = player_relative_position.normalized()
		elif player_relative_position.length() <= 400 and bounce_countdown == 0:
			# If player is within range, move toward it
			curspeed = actspeed
			print("player spotted")
			direction = player_relative_position.normalized()
		elif bounce_countdown == 0:
			
			# If player is too far, randomly decide whether to stand still or where to move
			curspeed = idlespeed
			print("target lost")
			var random_number = rng.randf()
			if random_number < 0.05:
				direction = Vector2.ZERO
			elif random_number < 0.1:
				direction = Vector2.DOWN.rotated(rng.randf() * 2 * PI)
		
		# Update bounce countdown
		if bounce_countdown > 0:
			bounce_countdown = bounce_countdown - 1
