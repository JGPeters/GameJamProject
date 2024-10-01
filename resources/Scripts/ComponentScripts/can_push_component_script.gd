extends ma_collision

func init(param_) -> void:
	get_owner().set_meta("can_push", true)

func collide(collided_entity : KinematicCollision2D) -> void:
	if collided_entity.get_collider().get_meta("pushable", false):
		collided_entity.get_collider().get_node("ComponentTree/InteractableComponent/PushableComponent").push(collided_entity.get_remainder().normalized())
