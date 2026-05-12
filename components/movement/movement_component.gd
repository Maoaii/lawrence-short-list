class_name MovementComponent
extends Node

@export var speed: float = 200.0
@export var acceleration: float = 800.0
@export var friction: float = 1200.0

func apply(body: CharacterBody2D, direction: float, delta: float) -> void:
    if direction != 0.0:
        body.velocity.x = move_toward(
            body.velocity.x, direction * speed, acceleration * delta
        )
    else:
        body.velocity.x = move_toward(body.velocity.x, 0.0, friction * delta)
