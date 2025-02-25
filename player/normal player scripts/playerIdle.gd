extends State
class_name Player_Idle

@export var parent: Player
	
func _enter():
	parent.sprite.animation = "standing"
	parent.sprite.play()
	parent.bounce_box.collision_mask = 0
	parent.velocity.y = 0
	parent.landed.emit()
	
func _exit():		#called upon exiting this state
	pass
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	if parent.direction:
		parent._walk()
		transitioned.emit(self,"walking")
		
	elif (parent.velocity.x):
		transitioned.emit(self,"sliding")
		
	elif !(parent._is_grounded()):
		transitioned.emit(self,"falling")
		
	if Input.is_action_just_pressed("space"):
		transitioned.emit(self,"jumping")
		
	parent._wrap_around()
