class_name StateMachine
extends Node

@export var debug_logs: bool = false
@export var initial_state: State

var current_state: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_machine = self
			
	current_state = initial_state
	if current_state:
		Logs.log("Setting initial state: " + current_state.name, self, debug_logs)
		current_state.enter(null)


func transition_to(new_state: State) -> void:
	if new_state == current_state:
		return
		
	Logs.log("Exiting state: " + current_state.name, self, debug_logs)
	current_state.exit(new_state)

	Logs.log("Entering state: " + new_state.name, self, debug_logs)
	var previous_state = current_state
	current_state = new_state
	new_state.enter(previous_state)

func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
