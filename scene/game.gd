extends Node2D


export var PLAYER_HP = 3
export var SCORE = 0
export var MAX_ENEMY = 15

const ENEMY_SCENE = preload("res://scene/enemy.tscn")


func _ready():
	$GUI.update_hp(PLAYER_HP)
	$GUI.update_score(SCORE)
	
	# spawn enemies
	for qi in range(MAX_ENEMY):
		_spawn_enemy()


func _on_Enemy_killed():
	_spawn_enemy()
	SCORE += 100
	$GUI.update_score(SCORE)


func _on_Player_take_damage():
	PLAYER_HP -= 1
	$GUI.update_hp(PLAYER_HP)
	
	if PLAYER_HP <= 0:
		$Player.visible = false
		$Player.set_physics_process(false)
		$GUI.display_game_over()


func _spawn_enemy():
	var enemy = ENEMY_SCENE.instance()
	add_child(enemy)


func _on_Player_stamina_changed(current_stamina):
	$GUI.update_stamina(current_stamina)
