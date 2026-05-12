class_name PlayerInputComponent
extends Node

func get_move_direction() -> float:
    return Input.get_axis("ui_left", "ui_right")

func is_jump_pressed() -> bool:
    return Input.is_action_just_pressed("ui_accept")

func is_jump_held() -> bool:
    return Input.is_action_pressed("ui_accept")
