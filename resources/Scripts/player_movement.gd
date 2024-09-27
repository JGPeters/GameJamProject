extends CharacterBody2D
class_name player

func _ready() -> void:
	for child in get_children():
		if child is component:
			child.init(null)
