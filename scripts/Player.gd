extends KinematicBody2D

var speed : int = 350
var pull : int = 10
var boost_strength : int = 100

var is_boosting : bool = false
var direction : Vector2 = Vector2.ZERO

onready var boost_timer : Timer = get_node("Boost Timer")

func _ready():
	set_physics_process(true)

func _input(event):
	if event.is_action_pressed("boost"):
		boost()

func _physics_process(delta):
	direction = Vector2.ZERO
	if is_boosting == true:
		direction.y -= boost_strength * delta
	else:
		direction.y += pull * delta

	if Input.is_action_pressed("move_right"):
		direction.x += speed * delta
	elif Input.is_action_pressed("move_left"):
		direction.x -= speed * delta

	move_and_collide(direction)

func boost():
	boost_timer.start()
	is_boosting = true
	yield(boost_timer, "timeout")
	is_boosting = false
