extends CharacterBody2D

@export var jump: JumpComponent
@export var state_machine: StateMachine
@export var bounce: BounceComponent

func _ready() -> void:
	if not jump:
		push_error("Player is missing a JumpComponent.")
		return
	if not state_machine:
		push_error("Player is missing a StateMachine.")
		return
	if not bounce:
		push_error("Player is missing a BounceComponent.")
		return

	bounce.bounced.connect(func():
		state_machine.transition_to(state_machine.get_node("Jump"))
	)
