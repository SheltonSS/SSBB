extends KinematicBody2D


# Declare member variables here. Examples:
var globalposition  


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	globalposition = global_transform.origin
	#print(globalposition)
	
