class_name JumpComponent
extends Node

signal jumped
signal landed

@export var jump_force: float = 500.0
@export var coyote_time: float = 0.12
@export var jump_buffer_time: float = 0.1

var _coyote_timer: Timer
var _buffer_timer: Timer
var _was_on_floor: bool = false

func _ready() -> void:
    _coyote_timer = Timer.new()
    _coyote_timer.one_shot = true
    add_child(_coyote_timer)

    _buffer_timer = Timer.new()
    _buffer_timer.one_shot = true
    add_child(_buffer_timer)

func tick(body: CharacterBody2D) -> void:
    if body.is_on_floor():
        _coyote_timer.stop()
        if not _was_on_floor:
            landed.emit()
        _was_on_floor = true
    else:
        if _was_on_floor:
            _coyote_timer.start(coyote_time)
        _was_on_floor = false

func request_jump() -> void:
    _buffer_timer.start(jump_buffer_time)

func can_jump() -> bool:
    return _was_on_floor or not _coyote_timer.is_stopped()

func try_jump(body: CharacterBody2D) -> bool:
    if not _buffer_timer.is_stopped() and can_jump():
        body.velocity.y = -jump_force
        _coyote_timer.stop()
        _buffer_timer.stop()
        jumped.emit()
        return true
    return false
