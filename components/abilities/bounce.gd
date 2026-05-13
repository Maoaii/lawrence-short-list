class_name BounceComponent
extends Node

signal bounced

@export var bounce_force: float = 700.0
@export var enabled: bool = true

func try_bounce(body: CharacterBody2D) -> bool:
    if not enabled:
        return false
    body.velocity.y = -bounce_force
    bounced.emit()
    return true
