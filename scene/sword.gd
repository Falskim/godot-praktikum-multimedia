extends Area2D


var allow_attack = true


func _ready():
	$CollisionPolygon2D.disabled = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		allow_attack = true


func attack():
	if allow_attack:
		allow_attack = false
		$CollisionPolygon2D.disabled = false
		$AnimationPlayer.play("attack")
		$AudioStreamPlayer.play()


func _on_Sword_body_entered(body):
	if body.is_in_group("Enemies"):
		body.take_damage()
