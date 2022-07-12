extends KinematicBody2D
var velocity = Vector2(1,0)
var speed = 500
export var rotation_speed = PI
var idle = true 
var foward = true
##PP = pivot point
onready var player := get_tree().get_root().get_node("MainScene").get_node("Player")
onready var pivotpoint := get_tree().get_root().get_node("MainScene").get_node("Player").get_node("TagSprite02-Sheet").get_node("Pivot").get_node("PivotBod")#.get_node("PlayerProj")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if idle == true:
		pass
	else:
		if foward == true:
			var collision_info = move_and_collide(velocity.normalized()*delta*speed)
			
		elif foward == false:
			#print("false foward")
			
			velocity = pivotpoint.global_position  - position
			var collision_info = move_and_collide(velocity.normalized()*delta*speed)
			if collision_info:
				if collision_info.get_collider() == pivotpoint:
					pivotpoint.get_node("PlayerProj").show()
					queue_free()
					print(collision_info.get_collider())
#func _process(delta):
#	$Sprite/Pivot.rotation += rotation_speed * delta


#func _on_Area2D_area_entered(area):
#	get_node("TagSprite02-Sheet/Pivot/PivotBod/PlayerProj").show()
#	print("free")
#	foward = true 
#	idle = true
#	#self.hide()
#	get_tree().queue_delete(self)
