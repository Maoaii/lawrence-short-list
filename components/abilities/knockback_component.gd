class_name KnockbackComponent
extends Node

signal knocked_back

@export var knockback_force: float = 1500.0
@export var enabled: bool = true

func apply_knockback(body: CharacterBody2D) -> bool:
    if not enabled:
        return false
        
    var mouse_pos = body.get_global_mouse_position()
    var direction = (body.global_position - mouse_pos).normalized()
    body.velocity = direction * knockback_force
    
    knocked_back.emit()
    return true
