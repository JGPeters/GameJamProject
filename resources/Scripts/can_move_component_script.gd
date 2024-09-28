extends component
class_name can_move_component

var movement_node : Node2D
var movement_attributes_list : Array = []

func init(_param) -> void:
	for comp in get_children():
		if comp is movement_component:
			if movement_node:
				print("Multiple movement components assigned to %s, using first one" % self)
			else:
				movement_node = comp
		if comp is movement_attribute:
			movement_attributes_list.append(comp)
		if comp != movement_node:
			comp.init(null)
	if !movement_node:
		print("No movement component assigned to %s" % self)
	else:
		movement_node.init(movement_attributes_list) # Error Invalid call, nonexistent fuction 'get_type' in base gd script
