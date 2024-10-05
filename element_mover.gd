extends Node2D

var element: ElementBase

func _ready() -> void:
	hide()
	
	var p := get_parent()
	
	while p is not ElementBase:
		p = p.get_parent()
	
	element = p

func refresh() -> void:
	if element.line == null:
		hide()
		return

	$Left.disabled = not element.line.has_free_position(element.index - 1)
	$Right.disabled = not element.line.has_free_position(element.index + 1)
	show()

signal interacted

func _on_right_pressed() -> void:
	interacted.emit()
	element.line.move_element(element.index, element.index + 1)


func _on_left_pressed() -> void:
	interacted.emit()
	element.line.move_element(element.index, element.index - 1)
