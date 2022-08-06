extends KinematicBody2D
var velocity = Vector2(1,0)
var speed = 500
export var rotation_speed = PI

var idle = true 
var foward = true
var delete = false
var perfectparry = false
var ppzone =false

onready var slime := get_tree().get_root().get_node("Slime")#.get_node("Slime")
onready var player := get_tree().get_root().get_node("MainScene").get_node("Player")
onready var PerfectParryArea :=get_tree().get_root().get_node("MainScene").get_node("Player").get_node("PerfectParryArea")

onready var pivotpointHB := get_tree().get_root().get_node("MainScene").get_node("Player").get_node("TagSprite02-Sheet").get_node("Pivot")#.get_node("PivotBod").get_node("PlayerProj")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if idle == true:
		pass
	else:
		if foward == true:
			player.get_node("Phitbot").disabled = true    
			var collision_info = move_and_collide(velocity.normalized()*delta*speed)
			if collision_info:
				if collision_info.get_collider().is_in_group ( "Enemy" ):
					foward = false
					enemycol(collision_info)

		elif foward == false:
			player.get_node("Phitbot").disabled = false
			velocity = player.position  - position
			var collision_info = move_and_collide(velocity.normalized()*delta*speed)
			if collision_info:
				if collision_info.get_collider() == player:
					delete = true
					queue_free()

				elif collision_info.get_collider().is_in_group ( "Enemy" ):
					enemycol(collision_info)

func enemycol(var collision_info):
	print("collision")
	perfectparry = true
	add_collision_exception_with(collision_info.get_collider())
	#disable hitbox/ collision
	pass
#	print("Enemy")

func wallcol (var collision_info):
	print("wall bounce")
	perfectparry = true
	
