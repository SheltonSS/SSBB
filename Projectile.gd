extends KinematicBody2D
var velocity = Vector2(1,0)
var speed = 500
export var rotation_speed = PI

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized()*delta*speed)

#func _process(delta):
#	$Sprite/Pivot.rotation += rotation_speed * delta
