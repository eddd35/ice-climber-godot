extends State
class_name Player_Fall

@export var parent: Player

func _enter():
	parent.landed.emit()
	parent.sprite.animation = "fall"
	parent.sprite.play()
	parent.falling.emit(parent.facing_left,0)
	
func _exit():		#called upon exiting this state
	parent.landed.emit()
	pass
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	parent.velocity.y += parent.gravity
	if parent.direction:
		parent._walk()
	
	if parent._is_grounded():
		transitioned.emit(self,"idle")
