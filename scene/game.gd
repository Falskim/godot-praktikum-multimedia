extends Node2D

export var PLAYER_HP = 5
export var SCORE = 0
export var MAX_ENEMY = 10

const ENEMY_SCENE = preload("res://scene/enemy.tscn")

func _ready():
	$GUI.update_hp(PLAYER_HP)
	$GUI.update_score(SCORE)
	
	# spawn enemies
	for i in range(MAX_ENEMY):
		spawn_enemy()


func _on_Enemy_killed():
	spawn_enemy()
	SCORE += 100
	$GUI.update_score(SCORE)


func _on_Player_take_damage():
	PLAYER_HP -= 1
	$GUI.update_hp(PLAYER_HP)
	if PLAYER_HP <= 0:
		$GUI.display_game_over()


func spawn_enemy():
	var enemy = ENEMY_SCENE.instance()
	add_child(enemy)
