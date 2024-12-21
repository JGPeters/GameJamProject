extends CharacterBody2D

@export var animation_tree : AnimationTree
@export var base_speed : float = 2000

var entity_manager : Node

func _ready() -> void:
	reset_speed()
	if get_owner() != self and get_owner() != null:
		print(get_owner())
		entity_manager = get_parent()
		tile_maps = get_tile_maps_from_level()
	print(tile_maps)
	$ComponentTree.init(null)

func get_tile_maps_from_level() -> Array[TileMapLayer]:
	var map_array : Array[TileMapLayer]
	for child : Node in $"../../TileMapLayerManager".get_children():
		if child is TileMapLayer:
			map_array.append(child)
	return map_array

var tile_maps : Array[TileMapLayer]
func get_tile_maps() -> Array[TileMapLayer]:
	return tile_maps

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

var can_move_x : bool = true
var can_move_y : bool = true
func set_can_move_x(Bool: bool) -> void:
	can_move_x = Bool
func set_can_move_y(Bool: bool) -> void:
	can_move_y = Bool
func get_can_move_x() -> bool:
	return can_move_x
func get_can_move_y() -> bool:
	return can_move_y

var current_speed : float
func get_speed() -> float:
	return current_speed
func set_speed(new_speed) -> void:
	current_speed = new_speed
func reset_speed() -> void:
	current_speed = base_speed

func _on_released_object() -> void:
	pass # Replace with function body.
