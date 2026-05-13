class_name MovingState
extends State

@export var input_component: PlayerInputComponent
@export var movement_component: MovementComponent
@export var gravity_component: GravityComponent
@export var jump_component: JumpComponent

@export var idle_state: State
@export var jump_state: State
@export var fall_state: State

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
    gravity_component.apply(owner, delta)
    movement_component.apply(owner, input_component.get_move_direction(), delta)
    owner.move_and_slide()

    if not owner.is_on_floor():
        state_machine.transition_to(fall_state)
        return

    if jump_component.try_jump(owner):
        state_machine.transition_to(jump_state)
        return

    if input_component.get_move_direction() == 0.0:
        state_machine.transition_to(idle_state)

func handle_input(_event: InputEvent) -> void:
    pass