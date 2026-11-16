extends Node2D

const TILE_SIZE = 40
const MAP_WIDTH = 32
const MAP_HEIGHT = 18

func _ready():
	queue_redraw()

func _draw():
	# Zelena trava
	for x in range(MAP_WIDTH):
		for y in range(MAP_HEIGHT):
			var rect = Rect2(
				x * TILE_SIZE,
				y * TILE_SIZE,
				TILE_SIZE,
				TILE_SIZE
			)
			draw_rect(rect, Color("#548b45"))

	# Krivudava putanja
	var path = [
		Vector2(0, 5),
		Vector2(8, 5),
		Vector2(8, 12),
		Vector2(17, 12),
		Vector2(17, 4),
		Vector2(26, 4),
		Vector2(26, 14),
		Vector2(32, 14)
	]

	for i in range(path.size() - 1):
		draw_line(
			path[i] * TILE_SIZE + Vector2(20, 20),
			path[i + 1] * TILE_SIZE + Vector2(20, 20),
			Color("#987044"),
			70.0
		)

	# Ivice putanje
	for i in range(path.size() - 1):
		draw_line(
			path[i] * TILE_SIZE + Vector2(20, 20),
			path[i + 1] * TILE_SIZE + Vector2(20, 20),
			Color("#c49a65"),
			3.0
		)
