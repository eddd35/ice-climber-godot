extends State
class_name Camera_Stop

@export var parent: Icies_Camera

func _enter():		#called upon entering this state
	parent.advance_box.body_entered.connect(advance_entered)
	
func _exit():		#called upon exiting this state
	parent.advance_box.body_entered.disconnect(advance_entered)
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	pass

func begin_advance():
	transitioned.emit(self,"advance")
	
func advance_entered(body: Node2D):
	if (body is Player or PlayerH):
		print(body.current_state)
		if body.current_state.to_lower() == "idle" || body.current_state.to_lower() == "sliding" || body.current_state.to_lower() == "walking":
			transitioned.emit(self,"advance")
