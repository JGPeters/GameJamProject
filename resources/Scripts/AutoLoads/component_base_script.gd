extends Node
class_name component

func init(_param) -> void:
	for child in get_children():
		if child is component:
			child.init(null)
