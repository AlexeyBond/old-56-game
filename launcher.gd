extends Node2D
class_name Launcher

@export
var capacity: int = 1

@export
var interval: float = 1.0

@export
var spacing: float = 10.0

var creature_scn := preload("res://creature.tscn")

var creatures: Array[Creature]

var starting: int = 0

func _ready() -> void:
	for i in range(capacity):
		var creature = creature_scn.instantiate()
		creature.position = Vector2(0, i * spacing)
		creatures.push_back(creature)
		add_child(creature)
	add_to_group("Launchers")

func reset_all():
	for i in range(creatures.size()):
		creatures[i].reset()
	
	$Timer.stop()
	starting = 0

func _start_one():
	creatures[starting].start_fall()
	starting += 1
	
	if starting < creatures.size():
		$Timer.start(interval)
		$Timer.one_shot = true

func start():
	reset_all()
	_start_one()

func reset():
	reset_all()
	$Button.disabled = false


func _on_button_pressed() -> void:
	start()
	#$Button.disabled = true


func _on_timer_timeout() -> void:
	_start_one()
