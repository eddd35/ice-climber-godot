extends State
class_name Player_Hammer

@export var parent: PlayerH

func _enter():
	parent._use_hammer()
	parent.sprite.animation = "attack"
	parent.swing_done.connect(_cease)
	pass
	
func _exit():		#called upon exiting this state
	pass
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	pass

func _cease():
	transitioned.emit(self, "idle")
	
