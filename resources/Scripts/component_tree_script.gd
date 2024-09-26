extends Node2D
class_name component

func init() -> void:
	for comp in get_children():
		comp.init()
