extends ElementBase
class_name ElementAdd

@export
var offset: int = 1

func _ready() -> void:
	super._ready()
	$Label.text = "%+d" % offset

func _on_ball_enter(ball: Creature):
	ball.start_transition($center.global_position + Vector2(unit * offset, 0))
