extends KinematicBody2D

class_name Player

export var Enable_Camera = true

onready var camera = $Camera2D
onready var sprite = $Sprite
onready var sword = $Sprite/Position2D/Sword

enum State {MOVE, IDLE}

const MOVE_SPEED = 1.5

export var ACCELERATION = 500
export var MAX_SPEED = 100
export var FRICTION = 500
var velocity = Vector2.ZERO


func _ready():
	camera.current = Enable_Camera


func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		sword.attack()


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		# flip asset
		if input_vector.x > 0:
			$Sprite.scale.x = 1
		elif input_vector.x < 0:
			$Sprite.scale.x = -1

		$AnimationPlayer.play("shake")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		$AnimationPlayer.stop()
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)

