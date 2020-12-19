extends KinematicBody2D


signal enemy_killed

export var ACCELERATION = 500
export var MAX_SPEED = 50
export var FRICTION = 500

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

enum State {MOVE, IDLE, DEAD}
var current_state


func _ready():
	randomize()
	# random spawn position
	global_position.x = randi() % 400 - 200
	global_position.y = randi() % 400 - 200

	if rand_range(0, 1) >= 0.5:
		_state_to_move()
	else:
		_state_to_idle()
	$Timer.start()


func _physics_process(delta):
	if current_state == State.DEAD:
		set_physics_process(false)
		
		# add score
		var current_scene = get_tree().get_current_scene()
		connect("enemy_killed", current_scene, "_on_Enemy_killed")
		emit_signal("enemy_killed")
		
		# play effect and animation
		$AudioDamaged.play()
		$AnimationPlayer.play("dead")
		return
	elif current_state == State.IDLE:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider.name == "Sword":
		current_state = State.DEAD


func _state_to_move():
	current_state = State.MOVE
	$AnimationPlayer.play("shake")
	
	# randomize move direction
	input_vector.x = rand_range(-1, 1)
	input_vector.y = rand_range(-1, 1)
	input_vector = input_vector.normalized()

	if input_vector.x > 0:
		$Sprite.scale.x = 1
	elif input_vector.x < 0:
		$Sprite.scale.x = -1


func _state_to_idle():
	current_state = State.IDLE
	$AnimationPlayer.stop()
	input_vector = Vector2.ZERO


func _on_Timer_timeout():
	if current_state == State.MOVE:
		_state_to_idle()
	elif current_state == State.IDLE:
		_state_to_move()
	$Timer.start()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "dead":
		queue_free()
