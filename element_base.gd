extends Area2D

class_name ElementBase

@export
var offset: int = 1

@export
var unit: float = 100

@export
var text: String = "XX"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	$Label.text = text

func _on_body_entered(body: Node2D):
	var creature := body.owner as Creature
	creature.start_transition(global_position + Vector2(unit * offset, 0))
