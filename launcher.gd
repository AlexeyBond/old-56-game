extends Node2D
class_name Launcher

var creature_scn := preload("res://creature.tscn")

var creature: Creature

func _ready() -> void:
	creature = creature_scn.instantiate()
	add_child(creature)
	add_to_group("Launchers")

func start():
	creature.reset()
	creature.start_fall()

func reset():
	creature.reset()
	$Button.disabled = false


func _on_button_pressed() -> void:
	start()
	#$Button.disabled = true
