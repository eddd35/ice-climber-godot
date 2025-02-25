extends Node
class_name State_Machine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

signal state_changed

func _ready() -> void:
	for child in get_children():	#Linear Search for child nodes
		if child is State:			#if there are children who are states
			states[child.name.to_lower()] = child	#add them to the 'states' dictionary
			child.transitioned.connect(_on_child_transition)	#connect the child's transition 
																#signal to state machine's transition function
	if initial_state:
		initial_state._enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:					
		current_state._update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_update(delta)
		
func _on_child_transition(state: State, new_state_name: String):	#swaps between states
	if state != current_state:		#ignore this function call if caller is not current state
		return
	
	var new_state = states.get(new_state_name.to_lower())	
	if !new_state:		#ignore this call if the proposed state doesn't exist
		return
		
	if current_state:	#exit the current state if the next state is valid
		current_state._exit()
	
	new_state._enter_name(state.name.to_lower())	#call the next state to be entered
	
	current_state = new_state	#set the new state to the current state
	
	state_changed.emit(current_state.name)
