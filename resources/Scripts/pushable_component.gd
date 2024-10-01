extends component
class_name  pushable_component

signal sliding(direction : Vector2i)

@export var sliding_time : float = 1 

var tile_map : TileMapLayer
var is_sliding : bool = false

func init(_param) -> void:
	get_owner().set_meta("pushable", true)
	get_owner().set_meta("collision_matters", true)
	tile_map = get_owner().get_parent()
	get_owner().position = calculate_destination( get_owner().position, Vector2.ZERO)
	
func push(velocity: Vector2):
	if is_sliding:
		return
	var move_to : = calculate_destination(get_owner().position, velocity.normalized())
	if can_move(move_to):
		var tween : Tween = create_tween()
		print(move_to)
		tween.tween_property(get_owner(), "position", move_to, sliding_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		is_sliding = true
		SignalBus.entity_pushed.emit(calculate_destination(tile_map.local_to_map(get_owner().position) - (velocity.normalized() as Vector2i), velocity.normalized()))
		await(tween.finished)
		is_sliding = false
	
func calculate_destination(start_point : Vector2, direction: Vector2i) -> Vector2:
	var tile_map_pos : Vector2 = tile_map.local_to_map(start_point) + direction
	print(tile_map_pos)
	return tile_map.to_global(tile_map.map_to_local(tile_map_pos))
	
func can_move(move_to: Vector2) -> bool:
	var future_transform : = Transform2D()
	future_transform.origin = move_to
	return not get_owner().test_move(future_transform, Vector2.ZERO)
