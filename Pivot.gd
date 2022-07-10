extends Node2D

export var rotation_speed = PI

func _proccess(delta):
	rotation += rotation_speed * delta
	print("test")
