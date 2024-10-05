extends Node2D

@export_file("*.tscn")
var next_level: String

func _control_interacted() -> void:
	for resettable in get_tree().get_nodes_in_group("resettable"):
		resettable.reset()

var finishing: bool = false

func _target_triggered() -> void:
	if finishing:
		return

	for target in get_tree().get_nodes_in_group("targets"):
		if not target.was_triggered:
			return

	finishing = true

	$AnimationPlayer.play("finish")

func _ready() -> void:
	%fader.show()
	for control in get_tree().get_nodes_in_group("controls"):
		control.interacted.connect(_control_interacted)
	for target in get_tree().get_nodes_in_group("targets"):
		target.triggered.connect(_target_triggered)
	%levelLabel.text = get_parent().scene_file_path
	$AnimationPlayer.play("start")

func end() -> void:
	get_tree().change_scene_to_file(next_level)
