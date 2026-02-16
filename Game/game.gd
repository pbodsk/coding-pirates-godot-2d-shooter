extends Node2D

var score = 0

func _ready() -> void:
	$Player.stop()
	$EnemySpawner.stop()
	$UI/CenterContainer/GameOver.hide()

func _on_start_pressed() -> void:
	$UI/CenterContainer/Start.hide()
	score = 0
	$UI/HUD.update_score(score)
	
	$Player.start()
	$EnemySpawner.start()


func _on_player_player_died() -> void:
	# Stop the game
	$Player.stop()
	$EnemySpawner.stop()
	
	# Show GAME OVER for 3 seconds
	$UI/CenterContainer/GameOver.show()
	await get_tree().create_timer(3).timeout
	$UI/CenterContainer/GameOver.hide()
	
	# Show Start
	$UI/CenterContainer/Start.show()


func _on_player_shield_changed(max_shield, shield) -> void:
	$UI/HUD.update_shield_bar(max_shield, shield)

func _on_enemy_spawner_scored_points(points: int) -> void:
	score += points
	$UI/HUD.update_score(score)
