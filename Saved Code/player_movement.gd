extends CharacterBody2D

@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		input_dir = input_dir.normalized() * speed
		
	move_and_collide(input_dir * delta)
	
