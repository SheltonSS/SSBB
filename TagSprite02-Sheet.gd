extends Sprite


# Declare member variables here. Examples:
var proj = preload("res://PivotPoint.tscn")
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("LMB"):
		fire()

func fire():
	var proj_instance = proj.instance()
	proj_instance.position = position
	#proj_instance.rotation_degrees = get_angle_to(MousePosition)
	#proj_instance.velocity = get_global_mouse_position() - proj_instance.position
	get_tree().get_root().call_deferred("add_child", proj_instance)
	#projarray.append(proj_instance)
	
