class_name MovementComponent
extends Node

@export var speed: float = 200.0
@export var acceleration: float = 800.0
@export var friction: float = 1200.0
@export var air_friction: float = 400.0

func apply(body: CharacterBody2D, direction: float, delta: float) -> void:
    var current_friction = friction if body.is_on_floor() else air_friction
    
    if direction != 0.0:
        var target_vel = direction * speed
        # If we're flying faster than normal speed in the same direction (momentum),
        # use friction to slowly decay down to normal speed instead of violently braking.
        if abs(body.velocity.x) > speed and sign(body.velocity.x) == sign(direction):
            body.velocity.x = move_toward(body.velocity.x, target_vel, current_friction * delta)
        else:
            body.velocity.x = move_toward(body.velocity.x, target_vel, acceleration * delta)
    else:
        body.velocity.x = move_toward(body.velocity.x, 0.0, current_friction * delta)