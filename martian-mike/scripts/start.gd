extends StaticBody2D

@onready var spawnPos = $SpawnPosition

func get_spawn_position():
	return spawnPos.global_position
