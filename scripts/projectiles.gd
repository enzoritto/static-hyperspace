extends Node2D

onready var warning_sprite = get_node("Warning Indicator")
onready var projectile_sprite = get_node("Projectile Sprite")
onready var delay_timer = get_node("Delay Timer")
onready var duration_timer = get_node("Duration Timer")

signal projectile_passed()

func _ready():
	self.translate(Vector2(rand_range(30, 450), 0))
	
	delay_timer.start()
	yield(delay_timer, "timeout")
	warning_sprite.visible = false
	
	projectile_sprite.visible = true
	duration_timer.start()
	yield(duration_timer, "timeout")
	emit_signal("projectile_passed")
	self.queue_free()
