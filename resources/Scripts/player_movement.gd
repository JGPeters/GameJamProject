extends CharacterBody2D

@export var animation_tree : AnimationTree

func _ready() -> void:
	$ComponentTree.init(null)

var health : int
func get_health() -> int:
	return health
func set_health(_health : int) -> void:
	health = _health

var facing_dir : Vector2
func get_facing_dir() -> Vector2:
	return facing_dir	
func set_facing_dir(dir : Vector2) -> void:
	facing_dir = dir

var last_movment_dir : Vector2
func get_last_movement_dir() -> Vector2:
	return last_movment_dir
func set_last_movement_dir(dir : Vector2) -> void:
	last_movment_dir = dir

var grabbing : bool = false
func get_grabbing() -> bool:
	return grabbing
func set_grabbing(Bool : bool) -> void:
	grabbing = Bool

func _on_released_object() -> void:
	pass # Replace with function body.
