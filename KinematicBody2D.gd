extends KinematicBody2D

# Declare member variables here. Examples:
onready var player := get_tree().get_root().get_node("MainScene").get_node("Player")
onready var camera := get_tree().get_root().get_node("MainScene").get_node("Camera2D")
var velocity = Vector2(1,0)
var target = Vector2(0,0)
var targetarea = 20
var speed = 240
var flingspeed = speed*3
var curspeed = speed 
var speedlist = [speed,flingspeed,0]
var onscreen = true 

var bouncetimer = 175

var flingtimer = 160
var hittimer = 50

var statelist = ["idle", "fling", "shoot", "bounce"]
var state = "fling"

func _ready():
	state = "idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (position.distance_to(player.position)) <= targetarea*4:
		set_collision_mask(513)
	print(get_collision_mask())
	print(position - player.get_position())
	if state == "fling":
		fling(delta)
	elif state == "idle":
		idle()
	if Input.is_action_just_pressed("fling"):
		print("f")
		print(flingtimer)
		flingtimer = 250
		state = "fling"
		
func fling(delta ):
	flingtimer -= 1
	if flingtimer == 0:
		target = player.position
		velocity = target - position
	elif flingtimer < 0 && flingtimer > -250*2:
		curspeed = speedlist[0]
		var collision_info = move_and_collide(velocity.normalized()*delta*speedlist[1])
		#keep going for 50 then stop 
		#also stop when you collide
		if position.distance_to(target) <= targetarea:
			print("target")
			set_collision_mask(513)
		
		if collision_info:
			if collision_info.get_collider() == player:
				wallbounce(collision_info)
				print("smack")
				
			elif collision_info.collider.name == "Kbodyboundry":
				print( collision_info.get_collider())
				if onscreen == true:
					print("on screen bounce")
					wallbounce(collision_info)
				else:
					print("collision exemption")
					add_collision_exception_with(collision_info.get_collider())
	elif flingtimer < -250:
		state="idle"
		print(flingtimer)

func idle():
	flingtimer = 125
	curspeed = speedlist[2]

func wallbounce(collision_info):
	velocity = velocity.bounce(collision_info.normal)

func _on_VisibilityNotifier2D_screen_exited():
	print("exit")
	pass

func _on_VisibilityNotifier2D_screen_entered():
	print("area entered")
	pass

func _on_Area2D_area_exited(area):
	if area.name == "Camarea":
		set_collision_mask(1)
		print("exit")
		pass
	
func _on_Area2D_area_entered(area):
		pass
