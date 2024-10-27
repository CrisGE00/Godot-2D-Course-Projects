extends CharacterBody2D

signal took_damage

var speed = 300
var rocket = preload("res://scenes/rocket.tscn")

@onready var rocketContainer = $RocketContainer
@onready var shootSound = $ShootSound

func _physics_process(delta: float) -> void:
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	
	move_and_slide()
	
	var screenSize = get_viewport_rect().size
	
	global_position = global_position.clamp(Vector2(0,0), screenSize)
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var rocketInstance = rocket.instantiate()
	rocketContainer.add_child(rocketInstance)
	rocketInstance.global_position = global_position
	rocketInstance.global_position.x += 80
	shootSound.play()

func take_damage():
	emit_signal("took_damage")

func die():
	queue_free()
