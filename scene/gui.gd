extends CanvasLayer


func update_hp(hp):
	$ProgressBar.value = hp


func update_score(score):
	$HBoxContainer/CurrentScore.text = str(score)
