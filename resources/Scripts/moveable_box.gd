extends CharacterBody2D
class_name moveable_box

signal pushed(direction : Vector2i)

func _ready() -> void:
	for child in get_children():
		if child is component:
			child.init(null)
