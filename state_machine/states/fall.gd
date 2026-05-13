class_name FallState
extends State

@export var input_component: PlayerInputComponent
@export var movement_component: MovementComponent
@export var gravity_component: GravityComponent
@export var jump_component: JumpComponent

@export var idle_state: State
@export var moving_state: State
@export var jump_state: State

func enter(_previous_state: State) -> void:
    pass

func exit(_next_state: State) -> void:
    pass

func process(_delta: float) -> void:
    pass

func physics_process(delta: float) -> void:
    if input_component.is_jump_pressed():
        jump_component.request_jump()

    jump_component.tick(owner)
    movement_component.apply(owner, input_component.get_move_direction(), delta)
    gravity_component.apply(owner, delta)
    owner.move_and_slide()

    if jump_component.try_jump(owner):
        state_machine.transition_to(jump_state)
        return

    if owner.is_on_floor():
        var dir := input_component.get_move_direction()
        state_machine.transition_to(moving_state if dir != 0.0 else idle_state)

func handle_input(_event: InputEvent) -> void:
    pass