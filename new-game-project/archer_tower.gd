extends Node2D

@export var attack_range: float = 200.0
@export var attack_damage: int = 10
@export var attack_speed: float = 1.0
@export var arrow_scene: PackedScene

var enemies_in_range: Array[Node2D] = []
var current_target: Node2D = null
var can_attack: bool = true


func _process(_delta):
	find_target()

	if current_target != null and can_attack:
		attack()


func find_target():
	current_target = null

	for enemy in enemies_in_range:
		if not is_instance_valid(enemy):
			continue

		if current_target == null:
			current_target = enemy


func attack():
	if not is_instance_valid(current_target):
		return

	can_attack = false

	var arrow = arrow_scene.instantiate()
	get_tree().current_scene.add_child(arrow)

	arrow.global_position = global_position
	arrow.set_target(current_target, attack_damage)

	await get_tree().create_timer(attack_speed).timeout
	can_attack = true


func _on_area_2d_body_entered(body):
	print("NEKO JE USAO U DOMET: ", body.name)
	print("DA LI JE ENEMY: ", body.is_in_group("enemies"))

	if body.is_in_group("enemies"):
		enemies_in_range.append(body)



func _on_area_2d_body_exited(body):
	enemies_in_range.erase(body)



func _on_area_2d_area_entered(area: Area2D):
	if area.name == "Hurtbox":
		var enemy = area.get_parent()
		if enemy.is_in_group("enemies"):
			enemies_in_range.append(enemy)
			print("ORC JE U DOMETU!")


func _on_area_2d_area_exited(area: Area2D):
	if area.name == "Hurtbox":
		var enemy = area.get_parent()
		enemies_in_range.erase(enemy)
		print("ORC JE IZAŠAO IZ DOMETA!")
