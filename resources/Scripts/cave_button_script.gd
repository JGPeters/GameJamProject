extends Area2D

var pressed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = true


func _on_body_entered(body: Node2D) -> void:
	if !pressed and body.get_meta("WeighsDownButtons", false):
		pressed = true
		SignalBus.button_pressed.emit(self)
		print("Button Pressed")


func _on_body_exited(body: Node2D) -> void:
	if pressed and !has_overlapping_bodies():
		print("Button Un-pressed")
		pressed = false
