extends State
class_name Player_Slide

@export var parent: Player
	
func _enter():
	parent.sprite.animation = "slide"
	parent.sprite.play()
	
func _exit():		#called upon exiting this state
	pass
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	if parent.direction:
		transitioned.emit(self, "walking")
		
	if !(parent.velocity.x):
		transitioned.emit(self,"idle")
	
	elif abs(parent.velocity.x) < parent.speed/20:
		parent.velocity.x = 0
	
	elif Input.is_action_just_pressed("space"):
		transitioned.emit(self,"jumping")
		
	else:
		parent.velocity.x -= sign(parent.velocity.x)*parent.speed/20
