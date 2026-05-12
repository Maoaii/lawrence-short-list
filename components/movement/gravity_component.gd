class_name GravityComponent
extends Node

@export var gravity: float = 980.0
@export var fall_multiplier: float = 1.6
@export var jump_gravity_scale: float = 0.6

var _is_jumping: bool = false

func set_jumping(value: bool) -> void:
    _is_jumping = value

func apply(body: CharacterBody2D, delta: float) -> void:
    if body.is_on_floor():
        return
    var scale := jump_gravity_scale if _is_jumping and body.velocity.y < 0.0 else fall_multiplier
    body.velocity.y += gravity * scale * delta
