extends Node2D


func _on_Button_pressed():
	get_tree().change_scene("res://scene/game.tscn")


func _on_Exit_pressed():
	get_tree().quit()
