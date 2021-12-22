extends CenterContainer

var inventory = preload("res://Game/Inventory/Inventory.tres")

onready var itemTextureRect = $ItemTextureRect
onready var itemAmountLabel = $ItemTextureRect/ItemAmountLabel
#onready var Global = get_node("/root/Global");

func display_item(item):
	if item is ItemResource:
		itemTextureRect.texture = item.texture
		itemAmountLabel.text = str(item.amount)
	else:
		itemTextureRect.texture = load("res://Game/Items/EmptyInventorySlot.png")
		itemAmountLabel.text = ""
		
		
func get_drag_data(_position):
	var item_index = get_index()
	var item = inventory.remove_item(item_index)
	if item is ItemResource:
		var data = {}
		data.item = item
		data.item_index = item_index
		
		var preview = Control.new()
		var dragPreview = TextureRect.new()
		#dragPreview.rect_position = Global.camera2D.global_position-_position-(get_viewport_rect().size/2)
		#dragPreview.rect_position.x += 10
		dragPreview.rect_position.y -= 10
		dragPreview.texture = item.texture
		preview.add_child(dragPreview)
		set_drag_preview(preview)
		inventory.drag_data = data
		return data
		
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
	if my_item is ItemResource and my_item.name == data.item.name and my_item.stackable and data.item.stackable:
		my_item.amount += data.item.amount
		inventory.emit_signal("items_changed", [my_item_index])
	else:
		inventory.swap_items(my_item_index, data.item_index)
		inventory.set_item(my_item_index, data.item)
	
	inventory.drag_data = null
