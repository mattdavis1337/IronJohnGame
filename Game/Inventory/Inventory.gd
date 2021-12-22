extends Resource

var drag_data = null

signal items_changed(indexes)

export(Array, Resource) var items = [
	null, null, null, null, null, null, null, null, null
]

func set_item(item_index, item):
	if(item is ItemResource):
		if(item_index == -1):
			item_index = find_empty_slot();
		#TODO: if no empty slot, drop the item back on the ground or something
		var previousItem = items[item_index]
		items[item_index] = item
		emit_signal("items_changed", [item_index])
		return previousItem;


func swap_items(item_index, target_item_index):
	var target_item = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = target_item
	emit_signal("items_changed", [item_index, target_item_index])

func remove_item(item_index):
	var previousItem = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
	return previousItem;

func find_empty_slot():
	for s in items.size():
		if(!items[s]):
			return s;

func make_items_unique():
	var unique_items = []
	for item in items:
		if item is ItemResource:
			unique_items.append(item.duplicate())
		else:
			unique_items.append(null)
	items = unique_items
