extends KinematicBody2D

# Declare member variables here. Examples:
onready var player := get_tree().get_root().get_node("MainScene").get_node("Player")
var velocity = Vector2(1,0)
var target #= player.position
var speed = 200
var flingtimer = 250
var hittimer = 50
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fling(delta)
	print(flingtimer)


func fling(delta ):
	flingtimer -= 1
	if flingtimer == 0:
	#	fling yourself at the target coords
		target = player.position
	elif flingtimer < 0 && flingtimer > -250:
		velocity = target - position 
		var collision_info = move_and_collide(velocity.normalized()*delta*speed*3)
		#keep going for 50 then stop 
		#also stop when you collide 
		if collision_info:
				if collision_info.get_collider() == player:
					print("smack")

	else:
		target = player.position
