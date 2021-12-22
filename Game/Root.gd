extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal create_item(item, position)

# Called when the node enters the scene tree for the first time.
func _ready():
	var displayNode = get_node("CanvasLayer/InventoryContainer/CenterContainer/InventoryDisplay");
	displayNode.connect("drop_signal", self, "_on_drop_signal")
	
	var items = get_node("WorldMap/WorldStuff/Items");
	connect("create_item", items, "item_factory")
	
	#story_test()
	pass # Replace with function body.

func story_test():
	var Story_Reader_Class = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	var Story_Reader = Story_Reader_Class.new()
	var story = load("res://Dialog-System-Example/stories/Example_Story_Baked.tres")
	
	Story_Reader.read(story)
	var did : int = 1
	var nid : int = 1
	var text : String = Story_Reader.get_text(did, nid)
	print(text)

func _on_drop_signal(item):
	var character = get_node("WorldMap/WorldStuff/Character");
	print("root: create item")
	emit_signal("create_item", item, character.position)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
