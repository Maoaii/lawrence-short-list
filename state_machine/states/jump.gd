class_name JumpState
extends State

@export var input_component: PlayerInputComponent
@export var movement_component: MovementComponent
@export var gravity_component: GravityComponent
@export var jump_component: JumpComponent

@export var fall_state: State

func enter(_previous_state: State) -> void:
    gravity_component.set_jumping(true)
    jump_component.try_jump(owner)

func exit(_next_state: State) -> void:
    gravity_component.set_jumping(false)

func process(_delta: float) -> void:
    pass

func physics_process(delta: float) -> void:
    if input_component.is_jump_pressed():
        jump_component.request_jump()

    if input_component.is_jump_released() and owner.velocity.y < 0.0:
        owner.velocity.y *= 0.5

    jump_component.tick(owner)
    movement_component.apply(owner, input_component.get_move_direction(), delta)
    gravity_component.apply(owner, delta)
    owner.move_and_slide()

    if owner.velocity.y >= 0.0:
        state_machine.transition_to(fall_state)

func handle_input(_event: InputEvent) -> void:
    pass