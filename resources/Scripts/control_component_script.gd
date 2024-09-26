extends component
class_name movement_component


@export var speed = 400
@export var can_Move = true

@export var controled_entity : Node2D
var movement_atributes : Array = []	

func assign_attributes(_movement_atributes) -> void:
	movement_atributes = _movement_atributes

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(can_Move == false):
		return
	var input_dir = Vector2.ZERO
	controled_entity.velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		input_dir.x += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("down"):
		input_dir.y += 1
	if Input.is_action_pressed("up"):
		input_dir.y -= 1
		
	if input_dir.length() > 0:
		controled_entity.velocity = input_dir.normalized() * speed
		
	controled_entity.move_and_collide(controled_entity.velocity * delta)
	
func _set_can_move(bVal):
	can_Move = bVal
