extends Node2D

var gameOverScreen = preload("res://scenes/game_over_screen.tscn")

var lives = 3
var score = 0

@onready var player = $Player
@onready var ui = $UI
@onready var hud = $UI/HUD
@onready var enemyHitSound = $EnemyHitSound
@onready var playerDamageSound = $PlayerDamageSound

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_death_zone_area_entered(area: Area2D) -> void:
	area.queue_free()


func _on_player_took_damage() -> void:
	lives -= 1
	hud.set_lives_label(lives)
	playerDamageSound.play()
	if lives == 0:
		player.die()
		await get_tree().create_timer(1.5).timeout
		var gameOverInstance = gameOverScreen.instantiate()
		gameOverInstance.set_score(score)
		ui.add_child(gameOverInstance)
	


func _on_enemy_spawner_enemy_spawned(enemyInstance: Variant) -> void:
	enemyInstance.connect("died", _on_enemy_died)
	add_child(enemyInstance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemyHitSound.play()


func _on_enemy_spawner_path_enemy_spawned(pathEnemyInstance: Variant) -> void:
	add_child(pathEnemyInstance)
	pathEnemyInstance.enemy.connect("died", _on_enemy_died)
