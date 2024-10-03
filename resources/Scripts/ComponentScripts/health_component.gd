extends Node2D
class_name health_component

signal died

@export var max_health: float = 100.0
var current_health : float

func _ready() -> void:
	current_health = max_health
	
func damage(damage_amount: float) -> void:
	current_health = max(current_health - damage_amount, 0)
	if current_health == 0:
		died.emit()
		# Do we want to break the node off? Probably...
		owner.queue_free()
