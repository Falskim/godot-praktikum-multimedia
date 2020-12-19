extends CanvasLayer


func update_hp(hp):
	$ProgressBar.value = hp


func update_score(score):
	$Score.text = "Score : " + str(score)


func display_game_over():
	$GameOver.visible = true
	$Score.visible = false
	$ProgressBar.visible = false
	$GameOver/GameOverScore.text = $Score.text 


func _on_Button_pressed():
	 get_tree().reload_current_scene()
