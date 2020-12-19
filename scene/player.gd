extends KinematicBody2D


signal take_damage

export var ACCELERATION = 500
export var MAX_SPEED = 100
export var FRICTION = 500
export var DAMAGED_KNOCKBACK = 150

var velocity = Vector2.ZERO


func _ready():
	$CollisionShape2D.disabled = false


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select"):
		 $Sprite/Position2D/Sword.attack()
		
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

		$AnimationMovement.play("shake")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		$AnimationMovement.stop()
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.collider
		if collider.is_in_group("Enemies"):
			velocity = (position - collider.position).normalized() * DAMAGED_KNOCKBACK
			$AudioDamaged.play()
			$AnimationDamaged.play("take_damage")
			emit_signal("take_damage")
