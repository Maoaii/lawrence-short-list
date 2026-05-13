class_name StretchSquashComponent
extends Node

@export var target: Sprite2D
@export var jump_scale: Vector2 = Vector2(0.7, 1.4)
@export var land_scale: Vector2 = Vector2(1.3, 0.7)
@export var duration: float = 0.12

@export var bottom_anchor_y: float = 64.0

var _tween: Tween
var _base_scale: Vector2 = Vector2.ONE
var _base_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
    if target:
        _base_scale = target.scale
        _base_pos = target.position
        
        var height = target.texture.get_size().y
        if target.centered:
            bottom_anchor_y = (height / 2.0) + target.offset.y
        else:
            bottom_anchor_y = height + target.offset.y

func on_jumped() -> void:
    _play(jump_scale, Vector2.ONE)

func on_landed() -> void:
    _play(land_scale, Vector2.ONE)

func _play(from_multiplier: Vector2, to_multiplier: Vector2) -> void:
    if not target:
        return
    if _tween:
        _tween.kill()
        
    var from_scale = from_multiplier * _base_scale
    var to_scale = to_multiplier * _base_scale
    
    # Calculate the world Y position of the anchor to keep it fixed
    var anchor_world_y = _base_pos.y + (bottom_anchor_y * _base_scale.y)
    var from_pos_y = anchor_world_y - (bottom_anchor_y * from_scale.y)
    var to_pos_y = anchor_world_y - (bottom_anchor_y * to_scale.y)
    
    _tween = create_tween().set_trans(Tween.TRANS_BACK)
    
    # Phase 1: Tween to stretched/squashed state
    _tween.tween_property(target, "scale", from_scale, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
    _tween.parallel().tween_property(target, "position:y", from_pos_y, duration)
    
    # Phase 2: Tween back to normal
    _tween.tween_property(target, "scale", to_scale, duration).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
    _tween.parallel().tween_property(target, "position:y", to_pos_y, duration)
