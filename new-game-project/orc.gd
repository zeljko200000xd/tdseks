extends Node2D

@export var speed: float = 100.0
@export var max_health: int = 100
@onready var health_bar = $HealthBar

var health: int
var path_follow: PathFollow2D


func _ready():
	
	health = max_health
	add_to_group("enemies")
	health_bar.max_value = max_health
	health_bar.value = health
	path_follow = get_parent() as PathFollow2D


func _process(delta):
	if path_follow == null:
		return

	path_follow.progress += speed * delta

	if path_follow.progress_ratio >= 1.0:
		queue_free()


func take_damage(amount: int):
	health -= amount
	health = max(health, 0)
	health_bar.value = health

	print("Orc HP: ", health)

	if health <= 0:
		die()


func die():
	print("Orc je poražen!")
	queue_free()
