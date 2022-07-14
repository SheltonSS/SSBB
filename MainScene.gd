extends Node2D

# Declare member variables here. Examples:
var slime = preload("res://Slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawnenemy():
	print("select")
	var slime_instance = slime.instance()
	slime_instance.position = $Player.global_position
	get_tree().get_root().call_deferred("add_child", slime_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		spawnenemy()
