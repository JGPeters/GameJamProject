extends Node
class_name component

func init(_param) -> void:
	for comp in get_children():
		comp.init(null)
