extends Node2D

@export_file("*.tscn")
var next_level: String

func _control_interacted() -> void:
	for resettable in get_tree().get_nodes_in_group("resettable"):
		resettable.reset()

var finishing: bool = false

func _are_all_targets_triggered() -> bool:
	for target in get_tree().get_nodes_in_group("targets"):
		if not target.was_triggered:
			return false
	return true

func _target_triggered() -> void:
	if finishing or not _are_all_targets_triggered():
		return

	finishing = true

	$AnimationPlayer.play("finish")

func _launcher_finished():
	for launcher in get_tree().get_nodes_in_group("launchers"):
		if not launcher.are_all_finished:
			return
	
	if _are_all_targets_triggered():
		return

	_control_interacted()

func _ready() -> void:
	%fader.show()
	for control in get_tree().get_nodes_in_group("controls"):
		control.interacted.connect(_control_interacted)
	for target in get_tree().get_nodes_in_group("targets"):
		target.triggered.connect(_target_triggered)
	for launcher in get_tree().get_nodes_in_group("launchers"):
		launcher.all_finished.connect(_launcher_finished)
	%levelLabel.text = get_parent().scene_file_path
	$AnimationPlayer.play("start")

func end() -> void:
	get_tree().change_scene_to_file(next_level)


func _on_restart_level_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_restart_all_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level0.tscn")
