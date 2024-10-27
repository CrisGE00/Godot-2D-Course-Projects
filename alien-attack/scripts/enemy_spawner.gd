extends Node2D

var enemyShip = preload("res://scenes/enemy.tscn")
var pathEnemy = preload("res://scenes/path_enemy.tscn")

signal enemy_spawned(enemyInstance)
signal path_enemy_spawned(pathEnemyInstance)

@onready var spawnPositions = $SpawnPositions

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy():
	var positions = spawnPositions.get_children()
	var randomSpawnPosition = positions.pick_random()
	var enemyInstance = enemyShip.instantiate()
	enemyInstance.global_position = randomSpawnPosition.global_position
	emit_signal("enemy_spawned", enemyInstance)
	#add_child(enemyInstance)


func _on_path_enemy_timer_timeout() -> void:
	spawn_path_enemy()

func spawn_path_enemy():
	var pathEnemyInstance = pathEnemy.instantiate()
	emit_signal("path_enemy_spawned", pathEnemyInstance)
