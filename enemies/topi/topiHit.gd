extends State
class_name TopiHit

@export var parent: Topi

func _enter():		#called upon entering this state
	parent.hurtbox.area_entered.connect(_hurtbox_entered)
	parent.sprite.animation = "hurt"
	parent.sprite.speed_scale = 2
	
	
func _exit():		#called upon exiting this state
	pass
	
func _update(delta: float):		#called every frame
	pass
	
func _physics_update(delta: float):		#called at a rate of 60 Hz
	pass

func _hurtbox_entered(area: Area2D):
	match(area.collision_layer):
		128:
			parent._turn()
			transitioned.emit(self,"TopiWander")
