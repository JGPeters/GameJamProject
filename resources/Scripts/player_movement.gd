extends CharacterBody2D

@export var animation_tree : AnimationTree

func _ready() -> void:
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
