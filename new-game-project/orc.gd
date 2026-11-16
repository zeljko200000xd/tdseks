extends Node2D

var speed = 100.0
var health = 100

var path_points = [
	Vector2(20, 220),
	Vector2(340, 220),
	Vector2(340, 500),
	Vector2(700, 500),
	Vector2(700, 180),
	Vector2(1060, 180),
	Vector2(1060, 580),
	Vector2(1280, 580)
]

var current_point = 1

func _process(delta):
	if current_point >= path_points.size():
		queue_free()
		return

	var target = path_points[current_point]
	var direction = global_position.direction_to(target)

	global_position += direction * speed * delta

	if global_position.distance_to(target) < 5:
		global_position = target
		current_point += 1

	queue_redraw()

func _draw():
	draw_circle(Vector2.ZERO, 15, Color("#287d32"))
	draw_circle(Vector2(-5, -4), 3, Color.WHITE)
	draw_circle(Vector2(5, -4), 3, Color.WHITE)
	draw_rect(Rect2(-10, 12, 20, 5), Color("#542b20"))
