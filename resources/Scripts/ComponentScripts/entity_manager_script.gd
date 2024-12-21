extends Node
class_name EntityManager

func _ready() -> void:
	SignalBus.something_grabbed_a_thing.connect(on_something_grabbed_a_thing)
	SignalBus.something_released_a_thing.connect(on_something_released_a_thing)
	SignalBus.send_tile_map_move.connect(on_send_tile_map_move)
	
	for child : Object in get_children():
		SignalBus.align_to_map.emit(child)

func on_something_grabbed_a_thing(grabber: Node2D, thing_grabbed: Object) -> void:
	pass
	#if grabber in get_children() and thing_grabbed in get_children():
		#thing_grabbed.reparent(grabber, true)
		#for child in thing_grabbed.get_children():
			#if child is CollisionShape2D:
				#var collision : CollisionShape2D = child.duplicate()
				#child.disabled = true
				#collision.set_meta("Temp", true)
				#collision.position = child.shape_owner_get_owner().position
				#grabber.add_child(collision)
				##child.set_meta("GrabbedCollision", true)
				##child.reparent(grabber, true)

func on_something_released_a_thing(grabber: Node2D, thing_grabbed: Object) -> void:
	pass
	#if thing_grabbed in grabber.get_children():
		#for child in grabber.get_children():
			#if child.get_meta("Temp", false):
				#child.queue_free()
		#thing_grabbed.reparent(self, true)
		#for child in thing_grabbed.get_children():
			#if child is CollisionShape2D:
				#child.disabled = false
		
func on_send_tile_map_move(actor : PhysicsBody2D, destination : Vector2, time : float) -> void:
	var tween : Tween = actor.create_tween()
	tween.tween_property(actor, "position", destination, time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
