extends StaticBody2D


var allow_attack = true


func _ready():
	$CollisionShape2D.disabled = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		allow_attack = true
		$CollisionShape2D.disabled = true;


func attack():
	if allow_attack:
		allow_attack = false
		$CollisionShape2D.disabled = false
		$AnimationPlayer.play("attack")
		$AudioStreamPlayer.play()
