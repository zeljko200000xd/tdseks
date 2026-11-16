
extends Area2D

@export var speed: float = 400.0

var target: Node2D
var damage: int = 100


func set_target(new_target: Node2D, new_damage: int):
	target = new_target
	damage = new_damage


func _process(delta):
	if not is_instance_valid(target):
		queue_free()
		return

	var direction = global_position.direction_to(target.global_position)

	global_position += direction * speed * delta
	rotation = direction.angle()


func _on_area_entered(area: Area2D):
	if not is_instance_valid(target):
		queue_free()
		return

	if area.name == "Hurtbox" and area.get_parent() == target:
		target.take_damage(damage)
		queue_free()
