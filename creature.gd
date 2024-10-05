extends Node2D
class_name Creature

var tw: Tween = null
var initial_gp: Vector2

var index: int

func _ready() -> void:
	initial_gp = global_position

func _kill_tween() -> void:
	if tw != null:
		tw.kill()
		tw = null

func _recreate_tween(connect: bool = true) -> void:
	_kill_tween()
	tw = get_tree().create_tween()
	if connect:
		tw.finished.connect(_on_finished)

func start_fall():
	_recreate_tween()
	tw.tween_property(
		self, "global_position", initial_gp + Vector2(0, 1000), 2
	).set_ease(Tween.EASE_IN)
	tw.play()
	is_finished = false

func start_transition(to_pos: Vector2) -> void:
	_recreate_tween()
	tw.tween_property(
		self, "global_position:x", (global_position.x + to_pos.x) / 2, .5
	).set_trans(Tween.TRANS_LINEAR)
	tw.parallel().tween_property(
		self, "global_position:y", to_pos.y - maxf(100, absf(global_position.x - to_pos.x)), .5
	).set_custom_interpolator(func(x): return 1.0 - pow(1.0 - x, 2))

	tw.tween_property(
		self, "global_position:x", to_pos.x, .5
	).set_trans(Tween.TRANS_LINEAR)
	tw.parallel().tween_property(
		self, "global_position:y", to_pos.y, .5
	).set_custom_interpolator(func(x): return x * x)

	tw.tween_property(
		self, "global_position", to_pos + Vector2(0, 1000), 2
	)#.set_custom_interpolator(func(x): return x * x)
	tw.play()
	is_finished = false

func stop():
	_kill_tween()
	_on_finished()

func reset() -> void:
	_recreate_tween(false)
	global_position = initial_gp + Vector2(0, -500)
	tw.tween_property(
		self, "global_position", initial_gp, .5 + 0.2 * index
	).set_custom_interpolator(func(x): return x * x)
	tw.play()
	$CBody.position = Vector2.ZERO
	is_finished = false

var is_finished: bool = false
signal finished

func _on_finished():
	is_finished = true
	finished.emit()
