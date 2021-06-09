extends KinematicBody2D

var speed : int = 350
var pull : int = 10
var boost_strength : int = 100
var boost_ammount : float = 0
var max_boost_ammount : float = 10

var is_boosting : bool = false
var direction : Vector2 = Vector2.ZERO

onready var boost_timer : Timer = get_node("Boost Timer")
onready var boost_bar : ProgressBar = get_node("../GUI/Boost Bar")

func _ready():
	set_process(true)

func _input(event):
	if event.is_action_pressed("boost") and boost_ammount >= max_boost_ammount:
		boost()

func _process(delta):
	boost_bar.value = boost_ammount
	
	if not boost_ammount >= max_boost_ammount:
		boost_ammount += 1 * delta
	
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
	boost_ammount = 0
	
	yield(boost_timer, "timeout")
	
	is_boosting = false
