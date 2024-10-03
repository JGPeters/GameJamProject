extends CharacterBody2D
 
@export var pathfinder: pathfind_component
@export var velocity_comp: velocity_component

@export var max_speed: float = 25 

var _player_can_move: bool = false

func _ready() -> void:
	_player_can_move = true
	pass
	
func _process(_delta: float) -> void:
	if !_player_can_move:
		return
	navigate_via_components()
	#var direction = get_direction_to_player()
	#velocity = direction * max_speed
	#move_and_slide()

func navigate_via_components() -> void:
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		print(player_node.global_position)
		pathfinder.set_target_position(player_node.global_position)
		pathfinder.follow_path()
		velocity_comp.move(self)
	else:
		pathfinder.set_target_position(global_position)
		pathfinder.follow_path()
		velocity_comp.move(self)

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if(player_node != null):
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
