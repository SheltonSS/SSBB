extends KinematicBody2D
var velocity = Vector2(1,0)
var speed = 500
export var rotation_speed = PI
var idle = true 
var foward = true
var delete = false
##PP = pivot point 
onready var slime := get_tree().get_root().get_node("Slime")#.get_node("Slime")
onready var player := get_tree().get_root().get_node("MainScene").get_node("Player")
onready var pivotbod := get_tree().get_root().get_node("PivotBod")
#onready var pivotpoint := get_tree().get_root().get_node("MainScene").get_node("Player").get_node("TagSprite02-Sheet").get_node("Pivot").get_node("PivotBod")#.get_node("PlayerProj")
onready var pivotpointHB := get_tree().get_root().get_node("MainScene").get_node("Player").get_node("TagSprite02-Sheet").get_node("Pivot")#.get_node("PivotBod").get_node("PlayerProj")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if idle == true:
		pass
	else:
		if foward == true:
#			print("shoot")
			player.get_node("CollisionShape2D").disabled = true    
			var collision_info = move_and_collide(velocity.normalized()*delta*speed)
			if collision_info:
				if collision_info.get_collider() == slime:
					foward = false
					enemycol(collision_info)

		elif foward == false:
			player.get_node("CollisionShape2D").disabled = false
			velocity = player.position  - position
			var collision_info = move_and_collide(velocity.normalized()*delta*speed)
			if collision_info:
				print(collision_info.get_collider())
				if collision_info.get_collider() == player:
					print("pp")
#					pivotpoint.get_node("PlayerProj").show()
#					pivotpointHB.visablity = true
					delete = true
					queue_free()
#					if is_instance_valid(pivotpoint):
#						pivotpoint.queue_free()

				elif collision_info.get_collider() == slime:
					enemycol(collision_info)

func enemycol(var collision_info):
	pass
#	print("slime")
#	collision_info.get_collider().queue_free()
#	queue_free()
