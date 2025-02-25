extends State

@export var parent: Player

func _enter():		#called upon entering this state
	parent.sprite.animation = "walk"
	parent.sprite.play()
	
func _exit():		#called upon exiting this state
	
	parent.sprite.speed_scale = 1
	pass
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	
	if !(parent.direction) && parent._is_grounded():
		transitioned.emit(self,"sliding")
		
	elif !(parent._is_grounded()):
		transitioned.emit(self,"falling")
		
	if parent.direction:
		parent._set_facing()
		parent._walk()
		parent.sprite.speed_scale = abs(parent.direction)
		parent.sprite.flip_h = !(parent.facing_left)
		
	if Input.is_action_just_pressed("space"):
		transitioned.emit(self,"jumping")
		
	if Input.is_action_just_pressed("shift"):
		transitioned.emit(self,"hammering")
		
	parent._wrap_around()
