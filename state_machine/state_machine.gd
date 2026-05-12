class_name StateMachine
extends Node

@export var debug_logs: bool = false
@export var initial_state: State


var current_state: State


func _ready() -> void:
    current_state = initial_state
    Logs.log("Setting initial state: " + current_state.name, self, debug_logs)


func transition_to(new_state: State) -> void:
    Logs.log("Exiting state: " + current_state.name, self, debug_logs)
    current_state.exit(new_state)

    Logs.log("Entering state: " + new_state.name, self, debug_logs)
    new_state.enter(current_state)

    current_state = new_state