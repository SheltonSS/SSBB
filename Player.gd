extends KinematicBody2D

const IdleSpeed = 10

export var rotation_speed = PI
export (int) var speed = 200
var velocity = Vector2()
var projspeed = 1000
var proj = preload("res://Projectile.tscn")
#var projarray = []
#var shoot = false
var orbitcoord

var PlayerAnim
var anim = ""
var animnew = ""

var MousePosition
var RotationAngle

func _ready():
	set_physics_process(true)
	PlayerAnim = get_node("PlayerAnimation")
	
func _process(_delta):
	$"TagSprite02-Sheet/Pivot".rotation += (rotation_speed*2) * _delta
	
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

	MousePosition = get_global_mouse_position()
	RotationAngle = get_angle_to(MousePosition)

	#print(RotationAngle)

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
	if Input.is_action_just_pressed("LMB"):
		fire()
	velocity = velocity.normalized() * speed
	
func fire():
	#shoot = true 
	orbitcoord = get_node("TagSprite02-Sheet/Pivot/KinematicBody2D/PlayerProj").global_position 
	orbitcoord.x = orbitcoord.x-40
	
	var proj_instance = proj.instance()
	proj_instance.position = orbitcoord
	proj_instance.rotation_degrees = get_angle_to(MousePosition)
	proj_instance.velocity = get_global_mouse_position() - proj_instance.position
	get_tree().get_root().call_deferred("add_child", proj_instance)
	#projarray.append(proj_instance)
