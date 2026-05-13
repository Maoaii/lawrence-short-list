class_name PlayerInputComponent
extends Node

@export var left_action: String = "left"
@export var right_action: String = "right"
@export var jump_action: String = "jump"

func get_move_direction() -> float:
    return Input.get_axis(left_action, right_action)

func is_jump_pressed() -> bool:
    return Input.is_action_just_pressed(jump_action)

func is_jump_held() -> bool:
    return Input.is_action_pressed(jump_action)

func is_jump_released() -> bool:
    return Input.is_action_just_released(jump_action)
