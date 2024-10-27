extends Area2D

@export var speed = 500

@onready var visibleNotifier = $VisibleNotifier

func _ready() -> void:
	visibleNotifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta: float) -> void:
	global_position.x += speed*delta

func _on_screen_exited():
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	area.die()
	queue_free()
