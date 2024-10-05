extends Node2D

var wp: Vector2i


func _ready() -> void:
	var p := get_parent()
	var np := "../.."
	while not p is PhysicsBody2D:
		p = p.get_parent()
		np += "/.."
	$PinJoint2D.node_b = NodePath(np)
	wp = get_window().position

func _physics_process(delta: float) -> void:
	var wpp := get_window().position
	
	$RigidBody2D.apply_impulse(-Vector2(wpp - wp))
	wp = wpp
