extends State
class_name Player_Jump

@export var parent: Player
	
func _enter():
	parent.sprite.animation = "jump"
	parent.sprite.play()
	parent.jumping.emit(parent.facing_left,2)
	parent._jump()
	
func _exit():		#called upon exiting this state
	pass
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	parent.velocity.y += parent.gravity
	#if parent.direction:
		#parent._walk()
		
	if parent.velocity.y > 0:
		transitioned.emit(self,"falling")
