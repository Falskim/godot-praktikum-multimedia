extends Node2D

export var PLAYER_HP = 5
export var SCORE = 0


func _ready():
	$GUI.update_hp(PLAYER_HP)
	$GUI.update_score(SCORE)


func _on_Enemy_killed():
	SCORE += 100
	$GUI.update_score(SCORE)


func _on_Player_take_damage():
	PLAYER_HP -= 1
	$GUI.update_hp(PLAYER_HP)
