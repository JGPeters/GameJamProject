extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		for component in child.get_children():
			if component is pushable_component:
				component.init(self)
		
