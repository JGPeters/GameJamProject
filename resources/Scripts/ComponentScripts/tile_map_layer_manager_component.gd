extends Node


var tile_map : TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("request_tile_map_move", on_request_tile_map_move)
	SignalBus.connect("align_to_map", align_to_map)
	tile_map = $TileMap

func on_request_tile_map_move(actor : PhysicsBody2D, actor2: PhysicsBody2D, move_dir : Vector2) -> void:
	var destination1: Vector2 = actor.position + ((move_dir as Vector2i * (tile_map.tile_set.tile_size / 2)) as Vector2)
	var destination2: Vector2 = actor2.position + ((move_dir as Vector2i * (tile_map.tile_set.tile_size / 2)) as Vector2)
	if check_move(destination1, actor) and check_move(destination2, actor2):
		SignalBus.send_tile_map_move.emit(actor, destination1, 0.6)
		SignalBus.send_tile_map_move.emit(actor2, destination2, 0.6)
	else:
		print("failed move")
		SignalBus.executed_tile_map_move.emit()

func check_move(move_to : Vector2, actor : PhysicsBody2D) -> bool:
	var destination : Transform2D = Transform2D()
	destination.origin = move_to
	return !actor.test_move(destination, Vector2.ZERO)

func align_to_map(actor: Object) -> void:
	actor.position = tile_map.map_to_local(tile_map.local_to_map(actor.position))
