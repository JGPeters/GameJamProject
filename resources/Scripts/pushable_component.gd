extends component
class_name  pushable_component

@onready var tween : Tween = get_tree().create_tween()
@onready var parent : Node2D = get_parent()

@export var sliding_time : float = 0.3 

var tile_map : TileMapLayer
var is_sliding : bool = false

func init(_tile_map : TileMapLayer) -> void:
	tile_map = _tile_map
	position = calculate_destination(Vector2.ZERO)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
func push(velocity: Vector2) -> void:
	if is_sliding:
		return
	var move_to : = calculate_destination(velocity.normalized())
	if can_move(move_to):
		tween.tween_property(get_parent(), "..:position", move_to, sliding_time)
		tween.play()
		is_sliding = true
		await(tween.finished)
		is_sliding = false
	
func calculate_destination(direction: Vector2) -> Vector2:
	var tile_map_pos : Vector2 = tile_map.local_to_map(get_owner().to_local(get_owner().position) + direction)
	return tile_map.to_global(tile_map.map_to_local(tile_map_pos))
	
func can_move(move_to: Vector2) -> bool:
	var future_transform : = Transform2D(transform)
	future_transform.origin = move_to
	return not parent.test_move(future_transform, Vector2.ZERO)
