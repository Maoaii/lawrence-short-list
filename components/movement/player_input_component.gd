class_name PlayerInputComponent
extends Node

@export var left_action: String = "left"
@export var right_action: String = "right"
@export var jump_action: String = "jump"

var _was_knockback_pressed := false

func get_move_direction() -> float:
    return Input.get_axis(left_action, right_action)

func is_jump_pressed() -> bool:
    return Input.is_action_just_pressed(jump_action)

func is_jump_held() -> bool:
    return Input.is_action_pressed(jump_action)

func is_jump_released() -> bool:
    return Input.is_action_just_released(jump_action)

func is_knockback_just_pressed() -> bool:
    var is_pressed = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
    if is_pressed and not _was_knockback_pressed:
        _was_knockback_pressed = true
        return true
    elif not is_pressed:
        _was_knockback_pressed = false
    return false
