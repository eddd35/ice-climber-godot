extends State
class_name TopiRetreat

@export var parent: Topi

func _enter():
	parent.hurtbox.area_entered.connect(_hurtbox_entered)
	parent.sprite.animation = "walk"
	parent.sprite.speed_scale = 2
	
	parent._turn()
	parent.velocity *= 2
	
func _exit():
	parent.hurtbox.area_entered.disconnect(_hurtbox_entered)
	
func _update(delta: float):
	pass
	
func _physics_update(delta: float):
	if !(parent.down.is_colliding):
		transitioned.emit(self,"TopiHit")
		parent.velocity.y = 100

func _hurtbox_entered(area: Area2D):
	match(area.collision_layer):
		8:
			parent._turn()
			transitioned.emit(self,"TopiHit")
		
		128:
			transitioned.emit(self,"TopiWander")
