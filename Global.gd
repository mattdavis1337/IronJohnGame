extends Node

var current_scene = null
var camera2D = null;

func _ready():
	camera2D = get_tree().get_root().get_node("Root/Camera2D")
	print(camera2D)
