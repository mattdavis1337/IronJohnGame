extends YSort

var item_dict = {}
export (Array, PackedScene) var itemArray

signal item_interaction(item_resource)

# Called when the node enters the scene tree for the first time.
func _ready():
	var _grabbed = connect("item_interaction", get_node("/root/Root/CanvasLayer/Dialog_Player"), "_event_item_grabbed")
	#createItems();
	#placeItems();
	registerItems();

func registerItems():
	var id = 1;
	for c in get_children():
		item_dict[c.item_resource.itemId] = c;
		id = id + 1;
	
func createItems():
	var id = 1;
	for c in get_children():
		#item_dict[c.item_resource.name+str(id)] = TallShieldItem.new();
		id = id + 1;
	pass;
	
	#item_dict["Sword"] = SwordItem.instance();

func placeItems():
	var keys = item_dict.keys();
	var offset = 0;
	for item in keys:
		item_dict[item].position = Vector2(550+offset, 300);
		offset += 50;
		add_child(item_dict[item]);

#Wired to item_grabbed event from from Item.gd
func _event_item_grabbed(item):
	print("Items: _event_item_grabbed")
	print(item)
	#Get a reference to the item	
	var character = get_node("../Character");
	#TODO: Change this to use CharacterReach radius
	var distance = character.get_global_position().distance_to(item.get_global_position());
	if(distance < 200): 
		character.receive_item(item)
		item_dict[item.item_resource.itemId] = null
		remove_child(item) 
	
	#emit_signal("item_interaction", item.item_resource)
	
	#var itemSprite = get_node(item.name+"Item");
	#item_dict[item.name].queue_free();
	
func item_factory(item_resource, loc):
	print("item factory");
	var item = load("res://Game/Items/"+item_resource.type+".tscn").instance()
	item.item_resource = item_resource;
	print("dropping item at:")
	print(loc)
	item.set_global_position(loc);
	add_child(item);
	item_dict[item_resource.itemId] = item
	print(item.item_resource.itemId)
	pass
