extends CharacterBody2D
class_name player

func _ready() -> void:
	var children = []
	for child in get_children():
		children.append(child)
		children.append_array(get_all_children(child))  # Recursively get nested children
	
	for child in children:
		if child is component:
			child.init([]) # Error Invalid call, nonexistent fuction 'get_type' in base gd script

func get_all_children(node: Node) -> Array:
	var all_children = []
	for child in node.get_children():
		all_children.append(child)
		all_children.append_array(get_all_children(child))  # Recursion
	return all_children
