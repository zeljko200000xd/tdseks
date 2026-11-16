

extends Node

@export var orc_scene: PackedScene

var base_health: int = 20
var current_wave: int = 0
var enemies_per_wave: int = 5
var spawn_delay: float = 2.0
var spawning: bool = false


func _ready():
	start_wave()


func start_wave():
	if spawning:
		return

	spawning = true
	current_wave += 1

	print("WAVE ", current_wave, " START!")

	for i in range(enemies_per_wave):
		spawn_orc()
		await get_tree().create_timer(spawn_delay).timeout

	spawning = false
	enemies_per_wave += 5
	spawn_delay = max(0.8, spawn_delay - 0.2)


func spawn_orc():
	if orc_scene == null:
		print("GRESKA: Orc Scene nije dodeljen!")
		return

	var path = get_parent().get_node_or_null("Path2D")

	if path == null:
		print("GRESKA: Path2D nije pronadjen!")
		return

	var follow = PathFollow2D.new()
	follow.loop = false
	follow.rotates = false
	path.add_child(follow)

	var orc = orc_scene.instantiate()
	follow.add_child(orc)
	orc.position = Vector2.ZERO

	print("NOVI ORK JE STVOREN!")


func damage_base(amount: int):
	base_health -= amount
	base_health = max(base_health, 0)

	print("BASE HEALTH: ", base_health)

	if base_health <= 0:
		game_over()


func game_over():
	print("GAME OVER!")
	get_tree().paused = true
