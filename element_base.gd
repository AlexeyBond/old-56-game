extends Area2D

class_name ElementBase

@export
var unit: float = 100

@export
var text: String = "XX"

var line: NumLine
var number: int
var index: int

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_ball_enter(_ball: Creature):
	pass

func _on_body_entered(body: Node2D):
	var creature := body.owner as Creature
	if creature != null:
		_on_ball_enter(creature)
