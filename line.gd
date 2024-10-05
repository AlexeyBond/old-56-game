@tool
extends Node2D

class_name NumLine

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

@export
var font: Font


var elements: Array[ElementBase] = []


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	elements.resize(1 + max_num - min_num)
	
	for ch in get_children():
		if ch is ElementBase:
			var elem_num := roundi((ch.global_position.x - global_position.x) / stride)
			assert(elem_num >= 0)
			assert(elem_num < elements.size())
			assert(elements[elem_num] == null)
			elements[elem_num] = ch
			ch.unit = stride
			ch.line = self
			ch.number = min_num + elem_num
			ch.index = elem_num
			ch.global_position = global_position + Vector2(stride, 0) * elem_num

	get_tree().call_group("movers", "refresh")

func has_free_position(pos: int) -> bool:
	if pos < 0:
		return false

	if pos >= elements.size():
		return false

	return elements[pos] == null

func move_element(pos: int, to: int) -> void:
	assert(elements[pos] != null)
	assert(elements[to] == null)
	
	elements[to] = elements[pos]
	elements[to].index = to
	elements[to].number = min_num + to
	elements[to].global_position = global_position + Vector2(stride, 0) * to
	elements[pos] = null
	
	get_tree().call_group("movers", "refresh")

func _draw() -> void:
	var p = Vector2.ZERO

	for i in range(min_num, max_num + 1):
		draw_circle(
			p, 10, color, false, 2.0, true
		)

		draw_string(
			font,
			p + Vector2(0, 40), "%s" % i, HORIZONTAL_ALIGNMENT_CENTER,
			-1, 16, color, TextServer.JUSTIFICATION_NONE,
			TextServer.DIRECTION_LTR, TextServer.ORIENTATION_HORIZONTAL
		)
		p.x += stride

	draw_line(
		Vector2(-stride / 2, 0), p, color, 2.0, true
	)
	
	draw_line(p, p - Vector2(stride / 3, stride / 5), color, 2.0, true)
	draw_line(p, p - Vector2(stride / 3, -stride / 5), color, 2.0, true)
