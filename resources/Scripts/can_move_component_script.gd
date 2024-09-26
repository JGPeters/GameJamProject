extends component
class_name can_move_component

var movement_node : Node2D
var movement_atributes : Array = []

func init() -> void:
	for comp in get_children():
		if comp is movement_component:
			if movement_node:
				print("Multiple movement components assigned to %s, using first one" % self)
			else:
				movement_node = comp
		if comp is movement_attribute:
			movement_atributes.append(component)
	if !movement_node:
		print("No movement component assigned to %s" % self)
	else:
		movement_node.assign_atributes(movement_atributes)
		for comp in get_children():
			comp.init()
