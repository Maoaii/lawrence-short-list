extends CharacterBody2D

@export var input_component: PlayerInputComponent
@export var jump: JumpComponent
@export var visual: StretchSquashComponent
@export var state_machine: StateMachine
@export var knockback: KnockbackComponent

func _ready() -> void:
	if jump and visual:
		jump.jumped.connect(visual.on_jumped)
		jump.landed.connect(visual.on_landed)

	if knockback and state_machine:
		knockback.knocked_back.connect(func():
			state_machine.transition_to(state_machine.get_node("JumpState"))
		)

func _process(_delta: float) -> void:
	if input_component and knockback and input_component.is_knockback_just_pressed():
		knockback.apply_knockback(self)
