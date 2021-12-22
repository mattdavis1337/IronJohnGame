extends ColorRect


#onready var topLeft = $root/Camera2D/Limits/TopLeft
#onready var bottomRight = $root/Camera2D/Limits/BottomRight
onready var topLeft = get_tree().get_root().get_node("Root/Camera2D/Limits/TopLeft")

func _ready():	
	rect_position.y = get_viewport_rect().size.y-rect_size.y
	#rect_position.x = get_viewport_rect().size.x-rect_size.x
