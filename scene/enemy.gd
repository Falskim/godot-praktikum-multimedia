extends KinematicBody2D

onready var sprite = $Sprite

enum State {MOVE, IDLE}

const MOVE_SPEED = 1.5

export var ACCELERATION = 500
export var MAX_SPEED = 50
export var FRICTION = 500

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

var current_state
var state_time


func start_state_timer():
#	$Timer.wait_time = rand_range(1, 3)
	$Timer.start()


func randomize_move_direction():
	input_vector.x = rand_range(-1, 1)
	input_vector.y = rand_range(-1, 1)
	input_vector = input_vector.normalized()


func state_to_move():
	current_state = State.MOVE
	$AnimationPlayer.play("shake")
	randomize_move_direction()

	if input_vector.x > 0:
		$Sprite.scale.x = 1
	elif input_vector.x < 0:
		$Sprite.scale.x = -1
	
	
func state_to_idle():
	current_state = State.IDLE
	$AnimationPlayer.stop()
	input_vector = Vector2.ZERO
	

func _ready():
	randomize()
	start_state_timer()
	if rand_range(0, 1) >= 0.5:
		state_to_move()
	else:
		state_to_idle()


func _physics_process(delta):
	if current_state == State.IDLE:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	if current_state == State.MOVE:
		state_to_idle()
		print("Idling")
	elif current_state == State.IDLE:
		state_to_move()
		print("Move")
	start_state_timer()
