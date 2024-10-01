extends CharacterBody2D

@export var animation_tree : AnimationTree

func _ready() -> void:
<<<<<<< Updated upstream
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
=======
	$ComponentTree.init(null)

var health : int
func get_health() -> int:
	return health

func set_health(_health : int) -> void:
	health = _health


var lastFacingDir : Vector2
func get_last_facing_dir() -> Vector2:
	return lastFacingDir
	
func set_last_facing_dir(dir : Vector2) -> void:
	lastFacingDir = dir


func _on_released_object() -> void:
	pass # Replace with function body.
>>>>>>> Stashed changes
