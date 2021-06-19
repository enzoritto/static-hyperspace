extends Node

onready var cooldown_timer = get_node("Cooldown Timer")

var projectile = preload("res://scenes/projectile.tscn")

func _ready():
	create_new_projectile()

func create_new_projectile():
	cooldown_timer.set_wait_time(rand_range(2, 4))
	cooldown_timer.start()
	
	yield(cooldown_timer, "timeout")
	
	add_child(projectile.instance())
	$Projectile.connect("projectile_passed", self, "create_new_projectile")
