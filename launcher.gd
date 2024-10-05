extends Node2D
class_name Launcher

@export
var capacity: int = 1

@export
var interval: float = 1.0

@export
var spacing: float = 20.0

var creature_scn := preload("res://creature.tscn")

var creatures: Array[Creature]

var starting: int = 0

func _ready() -> void:
	for i in range(capacity):
		var creature: Creature = creature_scn.instantiate()
		creature.position = -Vector2(0, i * spacing)
		creature.index = i
		creatures.push_back(creature)
		creature.finished.connect(_on_one_finished)
		add_child(creature)
	reset()
	add_to_group("Launchers")

var are_all_finished: bool = false
signal all_finished

func _on_one_finished() -> void:
	for c in creatures:
		if not c.is_finished:
			return
	are_all_finished = true
	all_finished.emit()

func _start_one():
	just_reset = false
	creatures[starting].start_fall()
	starting += 1

	if starting < creatures.size():
		$Timer.start(interval)
		$Timer.one_shot = true

func start():
	reset()
	_start_one()

var just_reset: bool = false

func reset():
	are_all_finished = false
	if just_reset:
		return

	for creature in creatures:
		creature.reset()

	$Timer.stop()
	starting = 0
	just_reset = true

	$Button.disabled = false

func _on_button_pressed() -> void:
	start()
	$Button.disabled = true


func _on_timer_timeout() -> void:
	_start_one()
