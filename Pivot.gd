extends Node2D

var velocity = global_position
var proj = preload("res://Projectile.tscn")

func spawnproj():
	velocity.x += 40
	print(global_position)
	var proj_instance = proj.instance()
	proj_instance.position = velocity
	proj_instance.rotation_degrees = get_angle_to(get_global_mouse_position())
	#proj_instance.velocity = get_global_mouse_position() - proj_instance.position
	get_tree().get_root().call_deferred("add_child", proj_instance)

func _proccess(delta):
	pass
