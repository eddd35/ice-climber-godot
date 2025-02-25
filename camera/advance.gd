extends State
class_name Camera_Advancing

@export var parent: Icies_Camera

var distance: int = 0

func _enter():		#called upon entering this state
	pass
	
func _exit():		#called upon exiting this state
	pass	
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	
	if distance < parent.max_travel:
		var travel: int = parent.max_travel*delta*5
		parent.position.y -= travel
		distance += travel
	
	if distance == parent.max_travel:
		distance = 0
		transitioned.emit(self,"stop")
		
	elif distance > parent.max_travel:
		parent.position.y += (distance - parent.max_travel)
