extends Node2D

@export var speed : float  = 1.0

@export var target : Node2D

func _process(delta: float) -> void:
	position = position.lerp(target.position, speed * delta)
