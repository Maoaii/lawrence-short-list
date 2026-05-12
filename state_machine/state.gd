# state.gd — base class
@abstract 
class_name State
extends Node

var state_machine: StateMachine

@abstract
func enter(_previous_state: State) -> void

@abstract
func exit(_next_state: State) -> void

@abstract
func process(_delta: float) -> void

@abstract
func physics_process(_delta: float) -> void

@abstract
func handle_input(_event: InputEvent) -> void