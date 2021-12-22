extends KinematicBody2D

var inventory = preload("res://Game/Inventory/Inventory.tres")
var inventoryDisplay = preload("res://Game/Inventory/InventoryDisplay.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = "right";
var speed = 180;
var held_directions = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Walk_down");
		

func _physics_process(_delta):
	for dir in ["left", "right", "up", "down"]:
		var is_pressed = Input.is_action_pressed("ui_"+dir);
		var index_of_direction = held_directions.find(dir);
		if index_of_direction == -1:
			if is_pressed:
				held_directions.push_front(dir);
		else:
			if !is_pressed:
				held_directions.remove(index_of_direction);
				
	if(held_directions.size() > 0):
		direction = held_directions[0];
		$AnimationPlayer.play("Walk_"+direction);
		var _velocity = move_and_slide(_get_movement(direction))
	
	#if Input.is_action_pressed("ui_down"):
		
		#move_and_slide(Vector2(0, speed));
	

func _get_movement(dir):
	var vectors = {
		"left": Vector2(-speed, 0),
		"right": Vector2(speed, 0),
		"up": Vector2(0, -speed),
		"down": Vector2(0, speed)
	}
	return vectors[dir];
	
func receive_item(item):
	print("Character: receive_item")
	print(item)
	inventory.set_item(-1, item.item_resource);
