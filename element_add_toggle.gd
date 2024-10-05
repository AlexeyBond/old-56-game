extends ElementAdd

@export
var offsets: Array[int] = []

var current_offsets: Array[int]

func _ready() -> void:
	super._ready()
	current_offsets = offsets.duplicate()
	offset = current_offsets[0]
	_render_label()


func _on_ball_enter(ball: Creature):
	super._on_ball_enter(ball)

	current_offsets.push_back(current_offsets.pop_front())
	offset = current_offsets[0]
	_render_label()

func _render_label():
	text = ""
	for off in current_offsets:
		text += "%+d\n" % off
	
	$Label.text = text

func reset():
	current_offsets = offsets.duplicate()
	offset = current_offsets[0]
	_render_label()
