extends CanvasLayer


func _ready():
	$GameOver.visible = false


func update_hp(hp):
	$ProgressBar.value = hp


func update_score(score):
	$HBoxContainer/CurrentScore.text = str(score)


func display_game_over():
	$GameOver.visible = true


func _on_Button_pressed():
	 get_tree().reload_current_scene()
