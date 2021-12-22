extends KinematicBody2D
class_name Item

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
export(Resource) var item_resource

signal item_grabbed

func _ready():
	var _grabbed = connect("item_grabbed", get_parent(), "_event_item_grabbed")
	pass # Replace with function body.

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	print("item clicked")
	if(event.is_action_released("ui_select")):
		emit_signal("item_grabbed", self)

func _on_Area2D_mouse_exited():
	print('mouse exit')
	print(item_resource.itemId)

func _on_Area2D_mouse_entered():
	print('mouse enter')
	print(item_resource.itemId)
