extends KinematicBody2D

var speed : int = 350
var direction : Vector2 = Vector2.ZERO
var pull : int = 5

func _ready():
	set_process(true)

func _process(delta):
	direction = Vector2.ZERO
	direction.y += pull * delta

	if Input.is_action_pressed("move_right"):
		direction.x += speed * delta
	elif Input.is_action_pressed("move_left"):
		direction.x -= speed * delta

	move_and_collide(direction)
