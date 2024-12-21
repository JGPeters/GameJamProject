extends Node
class_name signal_bus

signal something_grabbed_a_thing(grabber : Node, thing_grabbed : Object)
signal something_released_a_thing(grabber : Node, thing_grabbed : Object)

signal button_pressed(button : Node)

signal request_tile_map_move(actor : PhysicsBody2D, move_dir : Vector2)
signal send_tile_map_move(actor : PhysicsBody2D, desintation : Vector2, time : float)
signal executed_tile_map_move()
signal align_to_map(actor: Object)
