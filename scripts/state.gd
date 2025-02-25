extends Node
class_name State

signal transitioned		#signal to call for a state transition

var previous_state: String = "null"

func _enter_name(prev_name: String):	#saves the name of the previous state
	previous_state = prev_name
	_enter()
	
func _enter():		#called upon entering this state
	pass
	
func _exit():		#called upon exiting this state
	pass
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	pass
