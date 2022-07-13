extends Node2D
var count = 0 
var spin = true
var velocity = Vector2()
var MousePosition
var RotationAngle
var orbitcoord
var proj_instance = null
var projspeed = 500
var visablity =true
var delete = false
export var rotation_speed = PI
var proj = preload("res://Projectile.tscn")
onready var player := get_tree().get_root().get_node("MainScene").get_node("Player")

func _ready():
	if spin == true:
		pass
	else:
		pass
	
func spawnproj():
	if count < 1:
		proj_instance = proj.instance()
		proj_instance.position = velocity
		proj_instance.rotation_degrees = get_angle_to(get_global_mouse_position())
		get_node("PlayerProj").add_child(proj_instance)
		
func fire():
	#spawn the proj at the pivot sprites position and set it to shoot towards mouse position
	if count<1: 
		orbitcoord = $PivotBod/PlayerProj.get_global_position()
		orbitcoord.x = orbitcoord.x-0
		spin = false
		hide()
		visablity = false
		#get_node("TagSprite02-Sheet/Pivot/PivotBod/PlayerProj").hide() 
		proj_instance = proj.instance()
		proj_instance.idle = false
		proj_instance.speed = projspeed
		proj_instance.position = orbitcoord
#		proj_instance.rotation_degrees = Player.get_angle_to(MousePosition)
		proj_instance.velocity = get_global_mouse_position() - proj_instance.position
		get_tree().get_root().call_deferred("add_child", proj_instance)
		
func isvisable():
	return visablity

func _process(_delta):
	if spin==true:
		self.rotation += (rotation_speed*2) * _delta
	if (proj_instance != null):
		if is_instance_valid( proj_instance) == true:
#			player.projarray.remove(-1)
			queue_free()
