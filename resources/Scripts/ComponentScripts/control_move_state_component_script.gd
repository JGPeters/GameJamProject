extends State

signal start_interacting()
signal stop_interaction()

@export var speed : float = 40
@export var can_move : bool = true
@export var actor : Node2D

var normal_speed : float
var can_move_x : bool = true
var can_move_y : bool = true
var grabbing_object : bool = false

func set_can_movexy(bools : Array[bool]):
	can_move_x = bools[0]
	can_move_y = bools[1]

func _ready() -> void:
	normal_speed = speed
	set_physics_process(false)
	animations = ["Walk", "Idle"]

func enter_state() -> void:
	set_physics_process(true)

func exit_state() -> void:
	pass

func _physics_process(delta: float) -> void:
	if(can_move == false):
		return
		
	#Deal with interaction
	if Input.is_action_just_pressed("Interact"):
		$GrabHandler.grab_or_release()
		
	#Deal with movement
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("right") and can_move_x:
		input_dir.x += 1
	if Input.is_action_pressed("left") and can_move_x:
		input_dir.x -= 1
	if Input.is_action_pressed("down")and can_move_y:
		input_dir.y += 1
	if Input.is_action_pressed("up") and can_move_y:
		input_dir.y -= 1
		
	actor.velocity = Vector2.ZERO
	if input_dir.length() > 0:
		actor.velocity = input_dir.normalized() * speed
		#not grabbing, do that
		actor.set_last_facing_dir(actor.velocity)
		
	actor.move_and_slide()
	


func _on_grabbed_object(movement_restrictions: Dictionary) -> void:
	grabbing_object = true
	can_move_x = false
	can_move_y = false
	if movement_restrictions["x"] == 1 or  movement_restrictions["x"] == -1:
		can_move_x = true
	if movement_restrictions["y"] == 1 or  movement_restrictions["y"] == -1:
		can_move_y = true
	if movement_restrictions["Heavy"]:
		speed * .5
	else:
		speed = speed * .75
	
func _on_released_object() -> void:
	grabbing_object = false
	can_move_x = true
	can_move_y = true
	speed = normal_speed
