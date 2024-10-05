@tool
extends Node2D

@export
var min_num: int = 1:
	set(x):
		queue_redraw()
		min_num = x


@export
var max_num: int = 10:
	set(x):
		queue_redraw()
		max_num = x

@export
var stride: float = 100:
	set(x):
		queue_redraw()
		stride = x

@export
var color: Color = Color.RED:
	set(x):
		queue_redraw()
		color = x

func _draw() -> void:
	var p = Vector2.ZERO

	for i in range(min_num, max_num + 1):
		draw_circle(
			p, 10, color, false, 2.0, true
		)

		draw_string(
			ThemeDB.fallback_font,
			p + Vector2(0, 20), "%s" % i, HORIZONTAL_ALIGNMENT_LEFT, 2, 16, color, TextServer.JUSTIFICATION_NONE
		)
		p.x += stride

	draw_line(
		Vector2.ZERO, p, color, 2.0, true
	)
	
	draw_line(p, p - Vector2(stride / 3, stride / 5), color, 2.0, true)
	draw_line(p, p - Vector2(stride / 3, -stride / 5), color, 2.0, true)
