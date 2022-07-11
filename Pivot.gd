extends Node2D

#var proj = preload("res://Projectile.tscn")
var velocity = Vector2()
export var rotation_speed = PI

func _ready():
	#spawn the sprite as a child
	#var proj_instance = proj.instance()
	#proj_instance.position =Vector2(velocity.x+75,velocity.y)
	#proj_instance.rotation_degrees = rotation_degrees
	#proj_instance.velocity = get_global_mouse_position() - proj_instance.position
	#get_tree().get_root().call_deferred("add_child", proj_instance)
	pass

func _proccess(delta):
	rotation += rotation_speed * delta
	print("test")
	$Projectile/Pivot.rotation += rotation_speed * delta
