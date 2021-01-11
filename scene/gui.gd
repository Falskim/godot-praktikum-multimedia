extends CanvasLayer


func update_hp(hp):
	$VBoxContainer/HitpointBar.value = hp


func update_stamina(stamina):
	$VBoxContainer/StaminaBar.value = stamina


func update_score(score):
	$AnimationPlayer.play("score")
	$Score.text = "Score : " + str(score)


func display_game_over():
	$GameOver.visible = true
	$Score.visible = false
	$VBoxContainer/StaminaBar.visible = false
	$VBoxContainer/HitpointBar.visible = false
	$GameOver/GameOverScore.text = $Score.text 


func _on_Button_pressed():
	 get_tree().reload_current_scene()
