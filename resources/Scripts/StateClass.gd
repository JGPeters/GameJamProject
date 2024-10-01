extends Node
class_name State

var animations : Array[String]

func enter_state() -> void:
	pass

func exit_state() -> void:
	pass
	
func get_animations() -> Array[String]:
	return animations
