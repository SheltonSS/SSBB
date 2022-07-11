extends Node2D

export var rotation_speed = PI

func _process(delta):
	$"TagSprite02-Sheet/Node2D".rotation += (rotation_speed*2) * delta
