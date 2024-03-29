extends KinematicBody2D

const IdleSpeed = 10
var index = 0
var perrfectparry = false
var maxproj = 3
var currentproj = 0
export var rotation_speed = PI
export (int) var speed = 275
var velocity = Vector2()
var projspeed = 500
var proj = preload("res://Pivot.tscn")
var slime = preload("res://Slime.tscn")
var projarray = []
var ppzonearray = []

var PlayerAnim
var anim = ""
var animnew = ""

var MousePosition
var RotationAngle
var orbitcoord
var proj_instance


func _ready():
	set_physics_process(true)
	PlayerAnim = get_node("PlayerAnimation")
	
func _process(_delta):
	for i in projarray:
		if is_instance_valid(i) == false:
			projarray.remove(projarray.find(i))
	
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

	MousePosition = get_global_mouse_position()
	RotationAngle = get_angle_to(MousePosition)

	if (velocity.length() > IdleSpeed*0.09):
		if RotationAngle >= -2 and RotationAngle <= -1:
			anim = "M_Up"
		if RotationAngle >= -1 and RotationAngle <= -0.25:
			anim = "M_Up"
		if RotationAngle >= -0.25 and RotationAngle <= 0.25:
			anim = "M_Right"
		if RotationAngle >= 0.25 and RotationAngle <= 1:
			anim = "M_Right"
		if RotationAngle >= 1 and RotationAngle <= 2:
			anim = "M_Down"
		if RotationAngle >= 2 and RotationAngle <= 2.9:
			anim = "M_Down"
		if RotationAngle >= 2.9 or RotationAngle <= -2.9:
			anim = "M_Left"
		if RotationAngle >= -2.9 and RotationAngle <= -2:
			anim = "M_Left"
	else:
		if RotationAngle >= -2 and RotationAngle <= -1:
			anim = "I_Up"
		if RotationAngle >= -1 and RotationAngle <= -0.25:
			anim = "I_Up"
		if RotationAngle >= -0.25 and RotationAngle <= 0.25:
			anim = "I_Right"
		if RotationAngle >= 0.25 and RotationAngle <= 1:
			anim = "I_Right"
		if RotationAngle >= 1 and RotationAngle <= 2:
			anim = "I_Down"
		if RotationAngle >= 2 and RotationAngle <= 2.9:
			anim = "I_Down"
		if RotationAngle >= 2.9 or RotationAngle <= -2.9:
			anim = "I_Left"
		if RotationAngle >= -2.9 and RotationAngle <= -2:
			anim = "I_Left"
			
	if anim != animnew:
		animnew = anim
		PlayerAnim.play(anim)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("ui_com"):
		enableorbit()
	if Input.is_action_just_pressed("LMB"):

		print("click")
		fire()
	if Input.is_action_just_pressed("RMB"):
		enableorbit()
	if Input.is_action_just_pressed("ui_select"):
		pass
	velocity = velocity.normalized() * speed

func fire():
	if currentproj>0:
		print(projarray)
		for i in projarray:
			print(i)
			if is_instance_valid(i) == false:
				print("renoved: ")
				projarray.remove(projarray.find(i))
			else:
				if i.isvisable():
					print("fire")
					i.fire()
					break

	for i in ppzonearray:
		perfectparryup(i)
		
#		if i.get_collision_exceptions().size() > 0:
#			i.remove_collision_exception_with(i.get_collision_exceptions ( )[-1])
		break

func removedelobjects():
	for i in projarray:
			print(i)
			if is_instance_valid(i) == false:
				print("renoved: ")
				projarray.remove(projarray.find(i))

func enableorbit():
	if currentproj < 3:
		#spawn pivotpoint
		currentproj+=1
		proj_instance = proj.instance()
		projarray.append(proj_instance)
		get_node("TagSprite02-Sheet").add_child(proj_instance)
		
func reversefire():
#	make the ball go back towards the player location and then show the rotating sprite
#	does not work anymore (probobly)
#	print(projarray)
	if projarray.empty() == false && currentproj > 0:
		if is_instance_valid(projarray[-1]):
			projarray[-1].foward = false
			projarray.remove(projarray.size()-1)
			currentproj-=1
			
func _on_PerfectParryArea_body_entered(body):
		body.ppzone = true
		ppzonearray.append(body)
#	if body.perfectparry == true:
		print("Perfect Parry zone entered")
#		perrfectparry = true

func perfectparryup(proj):
	proj.foward = true
	proj.scale.x *= 1.1
	proj.scale.y *= 1.1
	proj.speed = proj.speed *1.2
	print(proj.scale)
	proj.ppzone = false
	proj.velocity = get_global_mouse_position() - proj.position
	if (proj.get_collision_exceptions ( ).size() > 0):
		for i in proj.get_collision_exceptions():
			proj.remove_collision_exception_with(proj.get_collision_exceptions ( )[-1])
	#increase dmg

func _on_PerfectParryArea_body_exited(body):
	print("No PP")
	body.perfectparry = false
	body.ppzone = false
	ppzonearray.remove(ppzonearray.find(body))
	pass # Replace with function body.

func _on_Boundry_body_entered(body):
#	print("wall bounce")
	if body.is_in_group ( "Enemy" ) == false:
		body.foward=false
		
		
	elif body.is_in_group ( "Enemy" ):
#		body.state="bounce"
#		var anglein = body.position.angle_to(self.position)
#		var angleout =  anglein - PI
#		var x1 = body.position.x
#		var y1 = body.position.y
#		print(anglein)
#		print(angleout)
#		var l = 50
#		var ang  = angleout
#		var endpoint = Vector2(x1 + l * cos(ang), y1 + l * sin(ang))
#		body.target = endpoint
#		body.velocity = body.target - position
		pass # Replace with function body.
