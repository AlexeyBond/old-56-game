extends Node2D
class_name Creature

var tw: Tween = null

func _kill_tween() -> void:
	if tw != null:
		tw.kill()
		tw = null

func _recreate_tween() -> void:
	_kill_tween()
	tw = get_tree().create_tween()
	tw.finished.connect(_on_finished)

func start_fall():
	_recreate_tween()
	tw.tween_property(
		self, "global_position", global_position + Vector2(0, 1000), 2
	).set_ease(Tween.EASE_IN)
	tw.play()

func start_transition(to_pos: Vector2) -> void:
	_recreate_tween()
	tw.tween_property(
		self, "global_position:x", (global_position.x + to_pos.x) / 2, .5
	).set_trans(Tween.TRANS_LINEAR)
	tw.parallel().tween_property(
		self, "global_position:y", to_pos.y - 100, .5
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

func reset() -> void:
	_kill_tween()
	global_position = get_parent().global_position
	$CBody.position = Vector2.ZERO

func _on_finished():
	print("finished")
