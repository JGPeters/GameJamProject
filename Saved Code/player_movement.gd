extends CharacterBody2D

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("right"):
		input_dir.x += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("down"):
		input_dir.y += 1
	if Input.is_action_pressed("up"):
		input_dir.y -= 1
		
	if input_dir.length() > 0:
		velocity = input_dir.normalized() * speed
		
	move_and_collide(input_dir * delta)
	
