extends ElementBase

var was_triggered: bool = false

@export
var untriggered_color: Color = Color.RED

@export
var triggered_color: Color = Color.GREEN

func _ready() -> void:
	super._ready()
	$Polygon2D.color = untriggered_color

func _on_ball_enter(ball: Creature) -> void:
	if was_triggered:
		return

	was_triggered = true
	ball.stop()
	triggered.emit()
	$Polygon2D.color = triggered_color

signal triggered

func reset() -> void:
	$Polygon2D.color = untriggered_color
	was_triggered = false
