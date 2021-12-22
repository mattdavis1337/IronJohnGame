extends GridContainer

var inventory = preload("res://Game/Inventory/Inventory.tres")
signal drop_signal(item)

func _ready():
	inventory.connect("items_changed", self, "_on_items_changed")
	inventory.make_items_unique()
	update_inventory_display()
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)	

func update_inventory_slot_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)	
	
func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)
		
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if (!(event.is_pressed()) and !(inventory.drag_data == null)):
			print('emitting signal drop_event')
			emit_signal("drop_signal", inventory.drag_data["item"])
			inventory.drag_data = null
		#elif !(event.is_pressed() and inventory.drag_data == null):

func snap_back(drag_data):
	if drag_data is Dictionary:
		inventory.set_item(drag_data.item_index, drag_data.item);
		inventory.drag_data = null;
			
	#print(event.as_text())
	#if event.is_action_released("ui_left_mouse"):
	#	print("unhandled input");
	#	print(event.as_text())
	#	if inventory.drag_data is Dictionary:
	#		inventory.set_item(inventory.drag_data.item_index, inventory.drag_data.item)
	pass;
